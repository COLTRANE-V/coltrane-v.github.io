# �️ Guida per i Maintainer del Sito COLTRANE-V

Questa guida spiega come mantenere e aggiornare il sito web [coltrane-v.github.io](https://coltrane-v.github.io).

---

## 📋 Indice

1. [Aggiungere un Team Member](#1️⃣-aggiungere-un-team-member)
2. [Aggiungere una Pubblicazione](#2️⃣-aggiungere-una-pubblicazione)
3. [Aggiungere un Repository](#3️⃣-aggiungere-un-repository)
4. [Sincronizzare il README del Profilo GitHub](#4️⃣-sincronizzare-il-readme-del-profilo-github)

---

## 1️⃣ Aggiungere un Team Member

### Passo 1: Aggiungi la foto

1. Salva la foto del membro in `team-photos/`
2. Nome file: `nome-cognome.jpg` (esempio: `mario-rossi.jpg`)
3. **Requisiti foto:**
   - Formato: JPG o PNG
   - Dimensione consigliata: almeno 400×400px
   - Orientamento: quadrato
   - Qualità: buona risoluzione

### Passo 2: Modifica `index.html`

Trova la sezione `<section class="team" id="team">` e aggiungi una nuova card:

```html
<!-- Mario Rossi -->
<div class="team-card">
    <img src="team-photos/mario-rossi.jpg" alt="Mario Rossi" class="member-photo">
    <h3>
        <a href="https://www.linkedin.com/in/mario-rossi/" 
           target="_blank" rel="noopener noreferrer">
            Prof./Dr. Mario Rossi
        </a>
    </h3>
    <a href="https://www.unito.it" target="_blank" rel="noopener noreferrer">
        <img src="img/unito-logo.png" alt="Università di Torino" class="university-logo">
    </a>
    <p class="bio">
        Breve biografia professionale (2-3 righe). Focus su ruolo, 
        area di ricerca e competenze principali nel progetto.
    </p>
    <a href="mailto:mario.rossi@unito.it" class="contact-btn">📧 Contatta</a>
</div>
```

**Note:**
- Aggiungi il logo dell'università in `img/` se non presente
- Mantieni lo stesso formato delle altre card

### Passo 3: Aggiorna `README.md`

Aggiungi il membro nella sezione `## 👥 Team`:

```markdown
### Prof./Dr. Mario Rossi
**Università di Torino** • [LinkedIn](https://www.linkedin.com/in/mario-rossi/)  
Breve biografia professionale (2-3 righe).  
📧 [mario.rossi@unito.it](mailto:mario.rossi@unito.it)
```

---

## 2️⃣ Aggiungere una Pubblicazione

### Passo 1: Modifica `index.html`

Trova la sezione `<section class="publications" id="publications">` e aggiungi la pubblicazione nell'anno corretto:

```html
<li>
    <strong>Titolo del Paper</strong> — 
    Conference/Journal — 
    <a href="https://doi.org/10.xxxx/xxxxx" target="_blank" rel="noopener noreferrer">DOI</a> | 
    <a href="https://arxiv.org/abs/xxxx.xxxxx" target="_blank" rel="noopener noreferrer">arXiv</a>
</li>
```

**Esempi:**

Solo DOI:
```html
<li>
    <strong>Title of the Paper</strong> — 
    IEEE Conference 2026 — 
    <a href="https://doi.org/10.1234/example" target="_blank" rel="noopener noreferrer">DOI</a>
</li>
```

Con arXiv:
```html
<li>
    <strong>Title of the Paper</strong> — 
    <a href="https://arxiv.org/abs/2602.12345" target="_blank" rel="noopener noreferrer">arXiv</a>
</li>
```

### Passo 2: Aggiorna `README.md`

Aggiungi nella sezione `## 📚 Pubblicazioni` sotto l'anno appropriato:

```markdown
- **Titolo del Paper**  
  *Conference/Journal*  
  [DOI](https://doi.org/10.xxxx/xxxxx) | [arXiv](https://arxiv.org/abs/xxxx.xxxxx)
```

### Passo 3: Sincronizza il profilo GitHub

```bash
./sync_readme_sections.sh
```

---

## 3️⃣ Aggiungere un Repository

### Passo 1: Modifica `index.html`

Trova la sezione `<table class="repos-table">` e aggiungi una nuova riga nella `<tbody>`:

```html
<tr>
    <td><code>NOME-REPO</code></td>
    <td>Descrizione breve e chiara del repository</td>
    <td>
        <a href="https://github.com/org/nome-repo" 
           target="_blank" rel="noopener noreferrer">GitHub</a>
    </td>
    <td>
        <a href="https://doi.org/10.xxxx/xxxxx" 
           target="_blank" rel="noopener noreferrer">Nome Paper (Anno)</a>
    </td>
</tr>
```

**⚠️ Importante:** Inserisci i repository in **ordine cronologico decrescente** per anno del paper (più recenti prima).

**Esempio completo:**

```html
<tr>
    <td><code>ML-DETECTOR</code></td>
    <td>Machine Learning-based Anomaly Detection System for RISC-V</td>
    <td>
        <a href="https://github.com/COLTRANE-V/ML-DETECTOR" 
           target="_blank" rel="noopener noreferrer">GitHub</a>
    </td>
    <td>
        <a href="https://doi.org/10.1234/mldetector2026" 
           target="_blank" rel="noopener noreferrer">ML Detector (2026)</a>
    </td>
</tr>
```

**Se non c'è paper correlato:**
```html
<td>—</td>
```

### Passo 2: Aggiorna `README.md`

Aggiungi nella tabella della sezione `## 🛠️ Repository del Progetto`:

```markdown
| **NOME-REPO** | Descrizione breve | [GitHub](https://github.com/org/nome-repo) | [Nome Paper (Anno)](https://doi.org/10.xxxx/xxxxx) |
```

Mantieni **ordine cronologico decrescente** (più recenti prima).

### Passo 3: Sincronizza il profilo GitHub

```bash
./sync_readme_sections.sh
```

---

## 4️⃣ Sincronizzare il README del Profilo GitHub

Il sito ha **due README**:
- **`README.md`**: README principale del repository (questo repo)
- **`../COLTRANE.github/profile/README.md`**: README che appare sul profilo GitHub dell'organizzazione

### ⚠️ Prerequisito: Clone del Repository .github

**Prima di poter sincronizzare**, devi clonare entrambi i repository nella stessa cartella:

```bash
cd /home/luca/Workspace/COLTRANE-V/

# Clona il repository del sito (se non l'hai già fatto)
git clone https://github.com/COLTRANE-V/coltrane-v.github.io.git

# Clona il repository del profilo GitHub
git clone https://github.com/COLTRANE-V/.github.git COLTRANE.github
```

**Struttura directory richiesta:**
```
/home/luca/Workspace/COLTRANE-V/
├── coltrane-v.github.io/          ← Repository del sito
│   ├── README.md
│   ├── sync_readme_sections.sh
│   └── ...
└── COLTRANE.github/                ← Repository del profilo
    └── profile/
        └── README.md
```

Lo script `sync_readme_sections.sh` si aspetta che il repository `.github` sia in `../COLTRANE.github/` rispetto alla directory corrente.

### Sincronizzazione Automatica

Quando aggiorni pubblicazioni o repository nel `README.md` principale, sincronizza automaticamente:

```bash
cd /home/luca/Workspace/COLTRANE-V/coltrane-v.github.io
./sync_readme_sections.sh
```

**Output atteso:**
```
🔍 Controllo sincronizzazione README...

📚 Confronto sezione Pubblicazioni...
🛠️ Confronto sezione Repository del Progetto...
✅ Tutto sincronizzato! Nessuna modifica necessaria.

✨ Done!
```

**Se ci sono differenze:**
```
⚠️  Sezione Pubblicazioni diversa!
⚠️  Sezione Repository del Progetto diversa!
📝 Aggiornamento in corso...
💾 Backup creato: ../COLTRANE.github/profile/README.md.backup_YYYYMMDD_HHMMSS
✅ Sincronizzazione completata!
```

### Cosa Sincronizza lo Script

Lo script sincronizza **automaticamente** queste sezioni dal README principale al README del profilo:

- ✅ **Pubblicazioni** (sezione `## 📚 Pubblicazioni`)
- ✅ **Repository del Progetto** (sezione `## 🛠️ Repository del Progetto`)

**Non sincronizza:**
- ❌ Introduzione
- ❌ Team
- ❌ Footer

### Backup Automatici

Ogni volta che lo script modifica il README del profilo, crea un backup:
`../COLTRANE.github/profile/README.md.backup_20260219_153045`

Per ripristinare un backup:
```bash
cp README.md.backup_YYYYMMDD_HHMMSS README.md
```

---

## 📁 Struttura del Repository

```
coltrane-v.github.io/
├── index.html                    # Landing page principale
├── style.css                     # Stili CSS
├── README.md                     # README principale (aggiorna qui!)
├── MAINTENERS.md                 # Questa guida
├── sync_readme_sections.sh       # Script di sincronizzazione
├── team-photos/                  # Foto dei membri del team
│   ├── README.md
│   ├── alessandro-savino.jpg
│   └── ...
└── img/                          # Loghi e immagini
    ├── logo_icon_transparent.png
    ├── polito-logo.png
    └── ...
```

---

## 🚀 Workflow Completo

### Scenario: Aggiungere una nuova pubblicazione

1. **Modifica `index.html`**: aggiungi il paper nella sezione Pubblicazioni
2. **Modifica `README.md`**: aggiungi il paper nella sezione Pubblicazioni
3. **Sincronizza profilo**: esegui `./sync_readme_sections.sh`
4. **Commit e push nel repository del sito**:
   ```bash
   git add index.html README.md
   git commit -m "Add new publication: Paper Title"
   git push
   ```
5. **Commit e push nel repository del profilo**:
   ```bash
   cd ../COLTRANE.github
   git add profile/README.md
   git commit -m "Sync publications: Paper Title"
   git push
   cd ../coltrane-v.github.io
   ```
6. **Verifica**: il sito si aggiorna automaticamente in 1-2 minuti su [coltrane-v.github.io](https://coltrane-v.github.io)

### Scenario: Aggiungere un repository con paper correlato

1. **Verifica che il paper sia già presente** nelle pubblicazioni
2. **Modifica `index.html`**: aggiungi repository nella tabella (ordine cronologico)
3. **Modifica `README.md`**: aggiungi repository nella tabella (ordine cronologico)
4. **Sincronizza profilo**: esegui `./sync_readme_sections.sh`
5. **Commit e push in entrambi i repository** (vedi Scenario precedente)
6. **Verifica sito**

---

## ✅ Checklist Manutenzione

Prima di fare push, verifica:

- [ ] Le immagini sono ottimizzate e caricate nella cartella corretta
- [ ] Tutti i link sono corretti e funzionanti
- [ ] I repository sono in ordine cronologico (anno più recente prima)
- [ ] Le pubblicazioni sono organizzate per anno
- [ ] Hai eseguito `./sync_readme_sections.sh` dopo modifiche a pubblicazioni/repository
- [ ] Il sito è stato testato localmente (apri `index.html` nel browser)
- [ ] I commit hanno messaggi descrittivi

---

## 🆘 Troubleshooting

### Lo script di sincronizzazione non funziona

```bash
chmod +x sync_readme_sections.sh
./sync_readme_sections.sh
```

### Il sito non si aggiorna dopo il push

- Attendi 2-3 minuti (GitHub Pages richiede tempo)
- Forza refresh nel browser: `Ctrl+F5` (Windows/Linux) o `Cmd+Shift+R` (Mac)
- Verifica che il push sia andato a buon fine: `git log --oneline -1`

### Errore nei link

Verifica che:
- Gli URL inizino con `https://`
- Non ci siano spazi negli URL
- Gli attributi HTML siano corretti: `target="_blank" rel="noopener noreferrer"`

---

## 📞 Contatti

**Domande o problemi?**  
Contatta: [luca.mannella@polito.it](mailto:luca.mannella@polito.it)

---

**Ultima modifica:** 19 febbraio 2026
