# Where Are You - PHP API con Docker

Questa guida spiega come eseguire l'API PHP "Where Are You" utilizzando Docker e Docker Compose.

## Prerequisiti

- Docker installato sul sistema
- Docker Compose installato sul sistema

## Configurazione rapida

### 1. Preparazione delle variabili d'ambiente

Modifica il file `.env.docker` con le tue configurazioni:

```bash
APP_ENV=prod
APP_SECRET=

# Numero massimo di minuti per mantenere la geolocalizzazione
MAX_MINUTES_TO_KEEP=5

# Chiave API per gli utenti normali
USER_API_KEY=la_tua_chiave_utente

# Chiave API per gli amministratori  
ADMIN_API_KEY=la_tua_chiave_admin
```

### 2. Avvio dei servizi

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
| `MAX_MINUTES_TO_KEEP` | Minuti per mantenere la geolocalizzazione | `5` |
| `USER_API_KEY` | Chiave API per utenti normali | `IDDKFA` |
| `ADMIN_API_KEY` | Chiave API per amministratori | `LMFAO` |


## Persistenza dei dati

Il database SQLite è memorizzato nella directory `./var/` che viene montata come volume Docker. I dati persisteranno anche dopo il riavvio dei container.

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
sudo chown -R $USER:$USER ./var/

# Riavvia i servizi
docker compose up -d
```

### Modificare la configurazione

Dopo aver modificato il file `.env.docker`:

1. Rigenera l'immagine Docker:
   ```bash
   docker compose build --no-cache
   ```

2. Riavvia i servizi:
   ```bash
   docker compose restart
   ```

## Sicurezza

- Cambia sempre le chiavi API di default prima di utilizzare l'applicazione in produzione
- Considera l'uso di HTTPS in produzione
- Limita l'accesso alla porta dell'API tramite firewall se necessario
