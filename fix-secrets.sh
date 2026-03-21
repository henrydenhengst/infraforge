#!/bin/bash
# fix-secrets.sh
# Lost GitHub Push Protection problemen op voor secrets

set -e

echo "🔐 GitHub Secrets Fix Script"
echo "============================"
echo ""

# Kleuren
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# -----------------------------------------------------------------------------
# 1. Controleer of we in de juiste directory zijn
# -----------------------------------------------------------------------------
if [ ! -f "ansible.cfg" ]; then
    echo -e "${RED}❌ Niet in de juiste directory (geen ansible.cfg gevonden)${NC}"
    exit 1
fi

# -----------------------------------------------------------------------------
# 2. Maak een veilige template aan (geen echte secrets)
# -----------------------------------------------------------------------------
echo -e "${YELLOW}📝 Aanmaken veilige template...${NC}"

cat > applications/secrets/vault/template-secrets.yml << 'EOF'
---
# =============================================================================
# SECRETS TEMPLATE - Kopieer dit bestand en versleutel het
# =============================================================================
# Gebruik: cp template-secrets.yml database.yml
#         ansible-vault encrypt database.yml
# =============================================================================

# -----------------------------------------------------------------------------
# DATABASE SECRETS
# -----------------------------------------------------------------------------
vault_postgres_password: "CHANGE_ME"
vault_mysql_root_password: "CHANGE_ME"
vault_mongodb_password: "CHANGE_ME"
vault_redis_password: "CHANGE_ME"

# App-specifieke database wachtwoorden
vault_nextcloud_db_password: "CHANGE_ME"
vault_wordpress_db_password: "CHANGE_ME"
vault_gitlab_db_password: "CHANGE_ME"

# -----------------------------------------------------------------------------
# GEBRUIKERS SECRETS
# -----------------------------------------------------------------------------
vault_admin_password: "CHANGE_ME"
vault_root_password: "CHANGE_ME"

vault_nextcloud_admin_password: "CHANGE_ME"
vault_gitlab_root_password: "CHANGE_ME"
vault_grafana_admin_password: "CHANGE_ME"

# -----------------------------------------------------------------------------
# API KEYS
# -----------------------------------------------------------------------------
vault_openai_key: "CHANGE_ME"
vault_slack_webhook: "CHANGE_ME"
vault_pagerduty_key: "CHANGE_ME"

# Cloud
vault_aws_access_key: "CHANGE_ME"
vault_aws_secret_key: "CHANGE_ME"
vault_google_client_id: "CHANGE_ME"
vault_google_client_secret: "CHANGE_ME"

# Git
vault_github_token: "CHANGE_ME"
vault_gitlab_token: "CHANGE_ME"

# DNS
vault_cloudflare_api_key: "CHANGE_ME"
vault_cloudflare_email: "CHANGE_ME"

# -----------------------------------------------------------------------------
# SMTP
# -----------------------------------------------------------------------------
vault_smtp_password: "CHANGE_ME"
vault_smtp_user: "noreply@company.local"
EOF

echo -e "${GREEN}✅ Template aangemaakt: applications/secrets/vault/template-secrets.yml${NC}"

# -----------------------------------------------------------------------------
# 3. Verwijder het oude example-secrets.yml uit Git
# -----------------------------------------------------------------------------
if [ -f "applications/secrets/vault/example-secrets.yml" ]; then
    echo -e "${YELLOW}🗑️  Verwijderen van example-secrets.yml uit Git...${NC}"
    git rm --cached applications/secrets/vault/example-secrets.yml 2>/dev/null || true
    rm -f applications/secrets/vault/example-secrets.yml
    echo -e "${GREEN}✅ example-secrets.yml verwijderd${NC}"
fi

# -----------------------------------------------------------------------------
# 4. Update .gitignore
# -----------------------------------------------------------------------------
echo -e "${YELLOW}📝 Update .gitignore...${NC}"

# Voeg secrets toe aan .gitignore (als ze er nog niet staan)
grep -q "applications/secrets/vault/*.yml" .gitignore || echo "" >> .gitignore
grep -q "applications/secrets/vault/*.yml" .gitignore || echo "# Secrets - NOOIT in Git!" >> .gitignore
grep -q "applications/secrets/vault/*.yml" .gitignore || echo "applications/secrets/vault/*.yml" >> .gitignore
grep -q "!applications/secrets/vault/README.md" .gitignore || echo "!applications/secrets/vault/README.md" >> .gitignore
grep -q "!applications/secrets/vault/template-*.yml" .gitignore || echo "!applications/secrets/vault/template-*.yml" >> .gitignore
grep -q "**/vault_pass.txt" .gitignore || echo "**/vault_pass.txt" >> .gitignore

echo -e "${GREEN}✅ .gitignore bijgewerkt${NC}"

# -----------------------------------------------------------------------------
# 5. Commit de wijzigingen
# -----------------------------------------------------------------------------
echo -e "${YELLOW}📦 Commit wijzigingen...${NC}"
git add .gitignore
git add applications/secrets/vault/template-secrets.yml
git commit -m "🔐 Fix: vervang example-secrets door veilige template

- Verwijder example-secrets.yml met echte secrets
- Voeg template-secrets.yml toe met placeholders
- Update .gitignore om echte secrets uit te sluiten
- Voeg instructies toe voor secrets management" 2>/dev/null || echo -e "${YELLOW}⚠️  Geen wijzigingen om te committen${NC}"

# -----------------------------------------------------------------------------
# 6. Push naar GitHub
# -----------------------------------------------------------------------------
echo -e "${YELLOW}📤 Pushen naar GitHub...${NC}"
git push origin main

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Push geslaagd!${NC}"
else
    echo -e "${RED}❌ Push mislukt. Controleer of je de laatste wijzigingen hebt gepulled:${NC}"
    echo -e "${YELLOW}   git pull --rebase${NC}"
    echo -e "${YELLOW}   git push${NC}"
    exit 1
fi

# -----------------------------------------------------------------------------
# 7. Instructies voor gebruik
# -----------------------------------------------------------------------------
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✅ Secrets fix voltooid!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "${YELLOW}📖 Hoe nu verder:${NC}"
echo ""
echo "1. Maak een nieuw secret bestand aan:"
echo "   cp applications/secrets/vault/template-secrets.yml applications/secrets/vault/database.yml"
echo ""
echo "2. Vul je echte secrets in:"
echo "   vim applications/secrets/vault/database.yml"
echo ""
echo "3. Versleutel het bestand:"
echo "   ansible-vault encrypt applications/secrets/vault/database.yml"
echo ""
echo "4. Voeg het versleutelde bestand toe aan Git:"
echo "   git add applications/secrets/vault/database.yml"
echo "   git commit -m 'Add encrypted secrets'"
echo "   git push"
echo ""
echo -e "${RED}⚠️  BELANGRIJK:${NC}"
echo "   - NOOIT onversleutelde secrets committen"
echo "   - Gebruik altijd ansible-vault voor echte wachtwoorden"
echo "   - Houd het vault wachtwoord veilig (niet in Git!)"
echo ""
