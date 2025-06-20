#!/bin/bash

# Script per testare la configurazione di sicurezza
# Uso: ./test-security.sh [URL_BASE]

URL_BASE=${1:-"http://localhost:8080"}

echo "🔒 Test Sicurezza - Where Are You API"
echo "======================================"
echo "URL Base: $URL_BASE"
echo ""

# Colori per output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Funzione per testare l'accesso a un file
test_access() {
    local file=$1
    local expected=$2
    local description=$3
    
    echo -n "Testing $description ($file)... "
    
    response=$(curl -s -o /dev/null -w "%{http_code}" "$URL_BASE/$file" 2>/dev/null)
    
    if [ "$response" = "$expected" ]; then
        echo -e "${GREEN}✓ OK${NC} (HTTP $response)"
    else
        echo -e "${RED}✗ FAIL${NC} (HTTP $response, expected $expected)"
    fi
}

echo "1. Test accesso file sensibili (dovrebbero restituire 403):"
echo "--------------------------------------------------------"
test_access "config.inc.php" "403" "File configurazione"
test_access "composer.json" "403" "File dipendenze"
test_access ".env" "403" "File environment"
test_access "data/db.sqlite" "403" "Database SQLite"
test_access "README.md" "403" "Documentazione"
test_access "generate-config.sh" "403" "Script configurazione"
test_access "Dockerfile" "403" "Dockerfile"
test_access "docker-compose.yml" "403" "Docker Compose"
test_access ".htaccess" "403" "File htaccess"
test_access "private/" "403" "Cartella private"
test_access "data/" "403" "Cartella data"

echo ""
echo "2. Test accesso file permessi (dovrebbero restituire 200):"
echo "--------------------------------------------------------"
test_access "api_position.php" "200" "API principale"

echo ""
echo "3. Test navigazione cartelle (dovrebbero restituire 403):"
echo "--------------------------------------------------------"
test_access "" "403" "Root directory listing"
test_access "private" "403" "Private directory"
test_access "data" "403" "Data directory"

echo ""
echo "2. Test accesso directory private (dovrebbero restituire 403):"
echo "------------------------------------------------------------"
test_access "private/" "403" "Directory private"
test_access "private/config.sample.php" "403" "Config sample in private"
test_access "private/docker-entrypoint.sh" "403" "Docker entrypoint in private"

echo ""
echo "3. Test accesso file pubblici (dovrebbero essere accessibili):"
echo "------------------------------------------------------------"
test_access "api_position.php" "200" "API endpoint principale"

echo ""
echo "4. Test metodi HTTP non permessi:"
echo "--------------------------------"
echo -n "Testing DELETE method... "
response=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE "$URL_BASE/api_position.php" 2>/dev/null)
if [ "$response" = "405" ] || [ "$response" = "403" ]; then
    echo -e "${GREEN}✓ OK${NC} (HTTP $response - metodo bloccato)"
else
    echo -e "${YELLOW}⚠ WARNING${NC} (HTTP $response - metodo non bloccato)"
fi

echo ""
echo "5. Test funzionalità API:"
echo "------------------------"
echo -n "Testing API GET request... "
response=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$URL_BASE/api_position.php" \
    -d "apikey=IDDKFA&getset=get&group=test" 2>/dev/null)
if [ "$response" = "200" ]; then
    echo -e "${GREEN}✓ OK${NC} (HTTP $response - API funzionante)"
else
    echo -e "${RED}✗ FAIL${NC} (HTTP $response - API non funzionante)"
fi

echo ""
echo "======================================"
echo "Test completato!"
echo ""
echo "Note:"
echo "- HTTP 403: Accesso negato (corretto per file sensibili)"
echo "- HTTP 200: Accesso consentito (corretto per API)"
echo "- HTTP 405: Metodo non permesso (corretto per sicurezza)"
