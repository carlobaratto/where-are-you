#!/bin/bash

# Script per verificare la struttura di sicurezza
echo "🔍 Verifica Struttura Sicurezza - Where Are You API"
echo "=================================================="

# Colori
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Contatori
PASSED=0
FAILED=0

# Funzione per verificare l'esistenza di un file
check_file() {
    local file=$1
    local should_exist=$2
    local description=$3
    
    if [ "$should_exist" = "true" ]; then
        if [ -f "$file" ]; then
            echo -e "${GREEN}✓${NC} $description: $file"
            ((PASSED++))
        else
            echo -e "${RED}✗${NC} $description: $file (MANCANTE)"
            ((FAILED++))
        fi
    else
        if [ ! -f "$file" ]; then
            echo -e "${GREEN}✓${NC} $description: $file (correttamente assente)"
            ((PASSED++))
        else
            echo -e "${YELLOW}⚠${NC} $description: $file (presente ma dovrebbe essere spostato)"
        fi
    fi
}

# Funzione per verificare l'esistenza di una directory
check_dir() {
    local dir=$1
    local should_exist=$2
    local description=$3
    
    if [ "$should_exist" = "true" ]; then
        if [ -d "$dir" ]; then
            echo -e "${GREEN}✓${NC} $description: $dir/"
            ((PASSED++))
        else
            echo -e "${RED}✗${NC} $description: $dir/ (MANCANTE)"
            ((FAILED++))
        fi
    fi
}

echo "1. File di sicurezza principali:"
echo "-------------------------------"
check_file ".htaccess" "true" "File .htaccess principale"
check_file "private/.htaccess" "true" "File .htaccess directory private"

echo ""
echo "2. File API pubblici:"
echo "--------------------"
check_file "api_position.php" "true" "API endpoint principale"

echo ""
echo "3. File di configurazione:"
echo "-------------------------"
check_file "config.inc.php" "true" "Configurazione attiva"
check_file "private/config.sample.php" "true" "Template configurazione (in private)"

echo ""
echo "4. Script di sistema:"
echo "--------------------"
check_file "generate-config.sh" "true" "Script wrapper configurazione"
check_file "private/generate-config.sh" "true" "Script configurazione originale (in private)"
check_file "private/docker-entrypoint.sh" "true" "Script Docker entrypoint (in private)"

echo ""
echo "5. Directory protette:"
echo "---------------------"
check_dir "private" "true" "Directory private"
check_dir "data" "true" "Directory database"

echo ""
echo "6. File di documentazione:"
echo "-------------------------"
check_file "README-SECURITY.md" "true" "Documentazione sicurezza"
check_file "SECURITY-SUMMARY.md" "true" "Riepilogo sicurezza"
check_file "private/DOCKER-SETUP-SUMMARY.md" "true" "Documentazione Docker (in private)"

echo ""
echo "7. Script di test:"
echo "-----------------"
check_file "test-security.sh" "true" "Script test sicurezza"
check_file "verify-structure.sh" "true" "Script verifica struttura"

echo ""
echo "=================================================="
echo -e "Risultati: ${GREEN}$PASSED passati${NC}, ${RED}$FAILED falliti${NC}"

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 Struttura di sicurezza configurata correttamente!${NC}"
    exit 0
else
    echo -e "${RED}❌ Alcuni controlli sono falliti. Verificare la configurazione.${NC}"
    exit 1
fi
