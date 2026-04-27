#!/bin/bash

# Script to synchronize the "Publications" and "Project Repositories" sections from the website README to the GitHub profile README

set -e

# File paths
SOURCE_README="README.md"
TARGET_README="../COLTRANE.github/profile/README.md"

# Output colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🔍 Checking README synchronization..."
echo ""

# Check that the files exist
if [ ! -f "$SOURCE_README" ]; then
    echo -e "${RED}❌ Source file not found: $SOURCE_README${NC}"
    exit 1
fi

if [ ! -f "$TARGET_README" ]; then
    echo -e "${RED}❌ Target file not found: $TARGET_README${NC}"
    exit 1
fi

# Extract a section from a README file
extract_section() {
    local file=$1
    local start_marker=$2
    local end_marker=$3
    
    awk "/$start_marker/,/$end_marker/ {print}" "$file" | sed '$d'
}

# Extract publications section
echo "📚 Comparing Publications section..."
SOURCE_PUBLICATIONS=$(extract_section "$SOURCE_README" "^## 📚 Publications" "^---$")
TARGET_PUBLICATIONS=$(extract_section "$TARGET_README" "^## 📚 Publications" "^---$")

# Extract repositories section
echo "🛠️  Comparing Project Repositories section..."
SOURCE_REPOS=$(extract_section "$SOURCE_README" "^## 🛠️ Project Repositories" "^---$")
TARGET_REPOS=$(extract_section "$TARGET_README" "^## 🛠️ Project Repositories" "^---$")

# Track whether there are changes
CHANGES_MADE=false

# Compare publications
if [ "$SOURCE_PUBLICATIONS" != "$TARGET_PUBLICATIONS" ]; then
    echo -e "${YELLOW}⚠️  Publications section differs!${NC}"
    CHANGES_MADE=true
else
    echo -e "${GREEN}✅ Publications section is already synchronized${NC}"
fi

# Compare repositories
if [ "$SOURCE_REPOS" != "$TARGET_REPOS" ]; then
    echo -e "${YELLOW}⚠️  Project Repositories section differs!${NC}"
    CHANGES_MADE=true
else
    echo -e "${GREEN}✅ Project Repositories section is already synchronized${NC}"
fi

# If there are differences, update the target file
if [ "$CHANGES_MADE" = true ]; then
    echo ""
    echo -e "${YELLOW}📝 Updating target README...${NC}"
    
    # Create backup
    BACKUP_FILE="${TARGET_README}.backup_$(date +%Y%m%d_%H%M%S)"
    cp "$TARGET_README" "$BACKUP_FILE"
    echo "💾 Backup created: $BACKUP_FILE"
    
    # Use Python to replace sections reliably
    python3 << 'PYEOF'
import re
import sys

BASE_URL = 'https://coltrane-v.github.io'

def absolutize_links(text):
    """Convert relative links to absolute links with the website domain."""
    def replace_link(m):
        label, url = m.group(1), m.group(2)
        if not re.match(r'^(https?://|#|/|mailto:)', url):
            url = BASE_URL + '/' + url
        return f'[{label}]({url})'
    return re.sub(r'\[([^\]]*)\]\(([^)]+)\)', replace_link, text)

# Read files
with open('README.md', 'r', encoding='utf-8') as f:
    source = f.read()

with open('../COLTRANE.github/profile/README.md', 'r', encoding='utf-8') as f:
    target = f.read()

# Extract publications section from source
pub_match = re.search(r'(## 📚 Publications.*?)(?=\n---\n)', source, re.DOTALL)
if pub_match:
    source_publications = absolutize_links(pub_match.group(1).rstrip())

    # Replace in target
    target = re.sub(
        r'## 📚 Publications.*?(?=\n---\n)',
        source_publications,
        target,
        flags=re.DOTALL
    )

# Extract repositories section from source
repo_match = re.search(r'(## 🛠️ Project Repositories.*?)(?=\n---\n)', source, re.DOTALL)
if repo_match:
    source_repos = absolutize_links(repo_match.group(1).rstrip())

    # Replace in target
    target = re.sub(
        r'## 🛠️ Project Repositories.*?(?=\n---\n)',
        source_repos,
        target,
        flags=re.DOTALL
    )

# Write updated file
with open('../COLTRANE.github/profile/README.md', 'w', encoding='utf-8') as f:
    f.write(target)

print("✅ Sezioni aggiornate con successo!")
PYEOF

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Synchronization completed!${NC}"
        echo ""
        echo "📋 Summary of updates:"
        if [ "$SOURCE_PUBLICATIONS" != "$TARGET_PUBLICATIONS" ]; then
            echo "  • Publications section updated"
        fi
        if [ "$SOURCE_REPOS" != "$TARGET_REPOS" ]; then
            echo "  • Project Repositories section updated"
        fi
    else
        echo -e "${RED}❌ Error while updating the target README${NC}"
        echo "Restoring backup..."
        mv "$BACKUP_FILE" "$TARGET_README"
        exit 1
    fi
else
    echo ""
    echo -e "${GREEN}✅ Everything is synchronized. No changes needed.${NC}"
fi

echo ""
echo "✨ Done!"
