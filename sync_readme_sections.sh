#!/bin/bash

# Script per sincronizzare le sezioni "Pubblicazioni" e "Repository del Progetto" 
# dal README del sito web al README del profilo GitHub

set -e

# Percorsi dei file
SOURCE_README="README.md"
TARGET_README="../COLTRANE.github/profile/README.md"

# Colori per output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🔍 Controllo sincronizzazione README..."
echo ""

# Verifica che i file esistano
if [ ! -f "$SOURCE_README" ]; then
    echo -e "${RED}❌ File sorgente non trovato: $SOURCE_README${NC}"
    exit 1
fi

if [ ! -f "$TARGET_README" ]; then
    echo -e "${RED}❌ File target non trovato: $TARGET_README${NC}"
    exit 1
fi

# Funzione per estrarre una sezione dal README
extract_section() {
    local file=$1
    local start_marker=$2
    local end_marker=$3
    
    awk "/$start_marker/,/$end_marker/ {print}" "$file" | sed '$d'
}

# Estrai sezione Pubblicazioni
echo "📚 Confronto sezione Pubblicazioni..."
SOURCE_PUBLICATIONS=$(extract_section "$SOURCE_README" "^## 📚 Pubblicazioni" "^---$")
TARGET_PUBLICATIONS=$(extract_section "$TARGET_README" "^## 📚 Pubblicazioni" "^---$")

# Estrai sezione Repository
echo "🛠️  Confronto sezione Repository del Progetto..."
SOURCE_REPOS=$(extract_section "$SOURCE_README" "^## 🛠️ Repository del Progetto" "^---$")
TARGET_REPOS=$(extract_section "$TARGET_README" "^## 🛠️ Repository del Progetto" "^---$")

# Flag per tracciare se ci sono cambiamenti
CHANGES_MADE=false

# Confronta Pubblicazioni
if [ "$SOURCE_PUBLICATIONS" != "$TARGET_PUBLICATIONS" ]; then
    echo -e "${YELLOW}⚠️  Sezione Pubblicazioni diversa!${NC}"
    CHANGES_MADE=true
else
    echo -e "${GREEN}✅ Sezione Pubblicazioni già sincronizzata${NC}"
fi

# Confronta Repository
if [ "$SOURCE_REPOS" != "$TARGET_REPOS" ]; then
    echo -e "${YELLOW}⚠️  Sezione Repository del Progetto diversa!${NC}"
    CHANGES_MADE=true
else
    echo -e "${GREEN}✅ Sezione Repository del Progetto già sincronizzata${NC}"
fi

# Se ci sono differenze, aggiorna il file target
if [ "$CHANGES_MADE" = true ]; then
    echo ""
    echo -e "${YELLOW}📝 Aggiornamento in corso...${NC}"
    
    # Crea backup
    BACKUP_FILE="${TARGET_README}.backup_$(date +%Y%m%d_%H%M%S)"
    cp "$TARGET_README" "$BACKUP_FILE"
    echo "💾 Backup creato: $BACKUP_FILE"
    
    # Usa Python per sostituire le sezioni in modo più affidabile
    python3 << 'PYEOF'
import re
import sys

# Leggi i file
with open('README.md', 'r', encoding='utf-8') as f:
    source = f.read()

with open('../COLTRANE.github/profile/README.md', 'r', encoding='utf-8') as f:
    target = f.read()

# Estrai sezione Pubblicazioni dal source
pub_match = re.search(r'(## 📚 Pubblicazioni.*?)(?=\n---\n)', source, re.DOTALL)
if pub_match:
    source_publications = pub_match.group(1).rstrip()
    
    # Sostituisci nel target
    target = re.sub(
        r'## 📚 Pubblicazioni.*?(?=\n---\n)',
        source_publications,
        target,
        flags=re.DOTALL
    )

# Estrai sezione Repository dal source
repo_match = re.search(r'(## 🛠️ Repository del Progetto.*?)(?=\n---\n)', source, re.DOTALL)
if repo_match:
    source_repos = repo_match.group(1).rstrip()
    
    # Sostituisci nel target
    target = re.sub(
        r'## 🛠️ Repository del Progetto.*?(?=\n---\n)',
        source_repos,
        target,
        flags=re.DOTALL
    )

# Scrivi il file aggiornato
with open('../COLTRANE.github/profile/README.md', 'w', encoding='utf-8') as f:
    f.write(target)

print("✅ Sezioni aggiornate con successo!")
PYEOF

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Sincronizzazione completata!${NC}"
        echo ""
        echo "📋 Riepilogo modifiche:"
        if [ "$SOURCE_PUBLICATIONS" != "$TARGET_PUBLICATIONS" ]; then
            echo "  • Sezione Pubblicazioni aggiornata"
        fi
        if [ "$SOURCE_REPOS" != "$TARGET_REPOS" ]; then
            echo "  • Sezione Repository del Progetto aggiornata"
        fi
    else
        echo -e "${RED}❌ Errore durante l'aggiornamento${NC}"
        echo "Ripristino backup..."
        mv "$BACKUP_FILE" "$TARGET_README"
        exit 1
    fi
else
    echo ""
    echo -e "${GREEN}✅ Tutto sincronizzato! Nessuna modifica necessaria.${NC}"
fi

echo ""
echo "✨ Done!"
