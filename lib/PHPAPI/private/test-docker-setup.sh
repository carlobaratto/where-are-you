#!/bin/bash

# Script di test per verificare la configurazione Docker
# Uso: ./test-docker-setup.sh

echo "🐳 Test della configurazione Docker per Where Are You - PHP API"
echo "=============================================================="

# Verifica che Docker sia installato
if ! command -v docker &> /dev/null; then
    echo "❌ Docker non è installato. Installa Docker per continuare."
    echo "   Ubuntu/Debian: sudo apt install docker.io"
    echo "   O segui le istruzioni su: https://docs.docker.com/install/"
    exit 1
fi

# Verifica che Docker Compose sia disponibile
if ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose non è disponibile. Assicurati che Docker sia installato e aggiornato."
    echo "   Ubuntu/Debian: sudo apt install docker.io"
    echo "   O aggiorna Docker alla versione più recente che include Compose V2"
    exit 1
fi

echo "✅ Docker e Docker Compose sono installati"

# Verifica che i file necessari esistano
FILES=("Dockerfile" "docker-compose.yml" ".env" "config.inc.php")
for file in "${FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "❌ File mancante: $file"
        if [ "$file" == ".env" ]; then
            echo "   Esegui: cp .env.example .env"
        elif [ "$file" == "config.inc.php" ]; then
            echo "   Esegui: ./generate-config.sh"
        fi
        exit 1
    else
        echo "✅ File presente: $file"
    fi
done

# Verifica che la directory data esista
if [ ! -d "data" ]; then
    echo "❌ Directory 'data' mancante"
    echo "   Esegui: mkdir -p data"
    exit 1
else
    echo "✅ Directory 'data' presente"
fi

echo ""
echo "🎉 Configurazione Docker completa e corretta!"
echo ""
echo "Per avviare l'API:"
echo "  docker compose up -d --build"
echo ""
echo "Per testare l'API:"
API_PORT=$(grep "^API_PORT=" .env 2>/dev/null | cut -d'=' -f2 || echo "8080")
echo "  curl -X POST http://localhost:${API_PORT}/api_position.php \\"
echo "    -H 'Content-Type: application/x-www-form-urlencoded' \\"
echo "    -d 'apikey=IDDKFA&getset=get&group=Test'"
