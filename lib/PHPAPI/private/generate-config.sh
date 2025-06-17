#!/bin/bash

# Script per generare il file config.inc.php dalle variabili d'ambiente
# Uso: ./generate-config.sh

# Carica le variabili d'ambiente dal file .env se esiste (nella directory principale)
if [ -f ../.env ]; then
    export $(cat ../.env | grep -v '^#' | xargs)
fi

# Valori di default
DB_FILE=${DB_FILE:-"./data/db.sqlite"}
MAX_MINUTES_TO_KEEP=${MAX_MINUTES_TO_KEEP:-5}
USER_API_KEY=${USER_API_KEY:-"IDDKFA"}
ADMIN_API_KEY=${ADMIN_API_KEY:-"LMFAO"}

# Genera il file config.inc.php nella directory principale
cat > ../config.inc.php << EOF
<?php

// Database path
\$dbFile = '${DB_FILE}';

// Max minutes to keep the user geolocalization
\$max_minutes_to_keep = ${MAX_MINUTES_TO_KEEP};

// User API key
\$user_api_key = '${USER_API_KEY}';

// Admin API key
\$admin_api_key = '${ADMIN_API_KEY}';

EOF

echo "File config.inc.php generato con successo!"
echo "Configurazione:"
echo "  - Database: ${DB_FILE}"
echo "  - Max minutes: ${MAX_MINUTES_TO_KEEP}"
echo "  - User API Key: ${USER_API_KEY}"
echo "  - Admin API Key: ${ADMIN_API_KEY}"
