# Where Are You - PHP API con Docker

Questa guida spiega come eseguire l'API PHP "Where Are You" utilizzando Docker e Docker Compose.

## Prerequisiti

- Docker installato sul sistema
- Docker Compose installato sul sistema

## Configurazione rapida

### 1. Preparazione delle variabili d'ambiente

Copia il file di esempio delle variabili d'ambiente:

```bash
cp .env.example .env
```

Modifica il file `.env` con le tue configurazioni:

```bash
# Porta su cui esporre l'API (default: 8080)
API_PORT=8080

# Percorso del file database SQLite (relativo al container)
DB_FILE=./data/db.sqlite

# Numero massimo di minuti per mantenere la geolocalizzazione
MAX_MINUTES_TO_KEEP=5

# Chiave API per gli utenti normali
USER_API_KEY=la_tua_chiave_utente

# Chiave API per gli amministratori  
ADMIN_API_KEY=la_tua_chiave_admin
```

### 2. Generazione del file di configurazione PHP

Esegui lo script per generare il file `config.inc.php`:

```bash
./generate-config.sh
```

Questo script leggerà le variabili dal file `.env` e creerà automaticamente il file `config.inc.php` necessario all'applicazione PHP.

### 3. Avvio dei servizi

Costruisci e avvia i container:

```bash
docker compose up -d --build
```

L'API sarà disponibile su `http://localhost:8080` (o sulla porta specificata in `API_PORT`).

## Gestione dei servizi

### Visualizzare i log

```bash
# Tutti i log
docker compose logs -f

# Solo i log dell'API
docker compose logs -f phpapi
```

### Fermare i servizi

```bash
docker compose down
```

### Riavviare i servizi

```bash
docker compose restart
```

### Aggiornare l'applicazione

```bash
# Ferma i servizi
docker compose down

# Ricostruisci l'immagine
docker compose build --no-cache

# Riavvia i servizi
docker compose up -d
```

## Variabili d'ambiente disponibili

| Variabile | Descrizione | Default |
|-----------|-------------|---------|
| `API_PORT` | Porta su cui esporre l'API | `8080` |
| `DB_FILE` | Percorso del database SQLite | `./data/db.sqlite` |
| `MAX_MINUTES_TO_KEEP` | Minuti per mantenere la geolocalizzazione | `5` |
| `USER_API_KEY` | Chiave API per utenti normali | `IDDKFA` |
| `ADMIN_API_KEY` | Chiave API per amministratori | `LMFAO` |

## Test dell'API

Una volta avviati i servizi, puoi testare l'API:

### Inserimento di una posizione (SET)

```bash
curl -X POST \
  http://localhost:8080/api_position.php \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'apikey=la_tua_chiave_utente&getset=set&group=Amici&name=Mario&lat=45.123456&lon=9.123456'
```

### Recupero delle posizioni (GET)

```bash
curl -X POST \
  http://localhost:8080/api_position.php \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'apikey=la_tua_chiave_utente&getset=get&group=Amici'
```

## Persistenza dei dati

Il database SQLite è memorizzato nella directory `./data/` che viene montata come volume Docker. I dati persisteranno anche dopo il riavvio dei container.

## Risoluzione dei problemi

### L'API non risponde

1. Verifica che i container siano in esecuzione:
   ```bash
   docker compose ps
   ```

2. Controlla i log per errori:
   ```bash
   docker compose logs phpapi
   ```

### Errori di permessi sul database

Se riscontri errori di permessi sul file SQLite:

```bash
# Ferma i servizi
docker compose down

# Correggi i permessi
sudo chown -R $USER:$USER ./data/

# Riavvia i servizi
docker compose up -d
```

### Modificare la configurazione

Dopo aver modificato il file `.env`:

1. Rigenera il file di configurazione:
   ```bash
   ./generate-config.sh
   ```

2. Riavvia i servizi:
   ```bash
   docker compose restart
   ```

## Sicurezza

- Cambia sempre le chiavi API di default prima di utilizzare l'applicazione in produzione
- Considera l'uso di HTTPS in produzione
- Limita l'accesso alla porta dell'API tramite firewall se necessario
