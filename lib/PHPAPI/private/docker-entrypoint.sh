#!/bin/bash
set -e

# Genera il file di configurazione se non esiste o se le variabili d'ambiente sono definite
if [ ! -f /var/www/html/config.inc.php ] || [ -n "$DB_FILE" ] || [ -n "$USER_API_KEY" ]; then
    echo "Generazione del file config.inc.php..."
    
    # Valori di default
    DB_FILE=${DB_FILE:-"./data/db.sqlite"}
    MAX_MINUTES_TO_KEEP=${MAX_MINUTES_TO_KEEP:-5}
    USER_API_KEY=${USER_API_KEY:-"IDDKFA"}
    ADMIN_API_KEY=${ADMIN_API_KEY:-"LMFAO"}
    
    # Genera il file config.inc.php
    cat > /var/www/html/config.inc.php << EOF
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
fi

# Assicurati che i permessi siano corretti
chown -R www-data:www-data /var/www/html/data
chmod 777 /var/www/html/data

# Esegui il comando originale
exec "$@"
