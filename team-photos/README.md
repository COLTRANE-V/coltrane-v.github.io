# Foto dei Team Member

Inserisci le foto dei team member in questa cartella con i seguenti nomi:

- `alessandro-savino.jpg` - Alessandro Savino (Politecnico di Torino)
- `luca-mannella.jpg` - Luca Mannella (Politecnico di Torino)
- `maurizio-palesi.jpg` - Maurizio Palesi (Università di Catania)
- `elio-vinciguerra.jpg` - Elio Vinciguerra (Università di Catania)
- `alessio-merlo.jpg` - Alessio Merlo (Università di Genova)

## Requisiti foto:
- **Formato**: JPG, PNG (consigliato JPG per ridurre peso file)
- **Dimensioni**: Minimo 200x200px, consigliato 300x300px (o superiore per alta qualità)
- **Tipo**: Fototessera o foto professionale con sfondo neutro
- **Peso**: Massimo 500KB per file
- **Orientamento**: Quadrato o ritagliabile a quadrato

## Effetti visuali nel sito:
- Le foto appaiono **circolari** con bordo colorato
- **Desktop/laptop con mouse**: effetto rotazione 3D di 360° quando passi il mouse sopra la foto
- **Mobile/tablet touch**: nessuna animazione, tap diretto al profilo LinkedIn
- Le foto sono **cliccabili** e portano al profilo LinkedIn del membro

## Come aggiungere un nuovo team member:

1. **Prepara la foto:**
   - Scarica o ritaglia la foto dai profili ufficiali dell'università
   - Rinomina la foto secondo la convenzione: `nome-cognome.jpg` (es: `mario-rossi.jpg`)
   - Carica il file in questa cartella `/team-photos/`

2. **Modifica `index.html`:**
   Vedi la guida completa in [MAINTENERS.md](../MAINTENERS.md#1️⃣-aggiungere-un-team-member)
   
   La struttura HTML deve includere:
   ```html
   <a href="LINK_LINKEDIN" class="member-photo-link" target="_blank" rel="noopener noreferrer">
       <img src="team-photos/nome-cognome.jpg" alt="Nome Cognome" class="member-photo">
   </a>
   ```
   
   ⚠️ **Importante**: La foto dev'essere avvolta nel tag `<a>` con classe `member-photo-link` per avere l'effetto 3D!

3. **Commit e push su GitHub**

## Alternative se la foto non è disponibile:
Se non trovi una foto ufficiale, puoi usare un'immagine placeholder vuota (es: `placeholder.jpg`) e la card avrà comunque il giusto layout.
