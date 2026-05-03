#!/bin/bash
# Deployment script voor Linux Café Haarlem (LOCALHOST)

set -e

echo "🚀 Start deployment Linux Café Haarlem (localhost)"
echo "================================"

# Check prerequisites
if ! command -v ansible-playbook &> /dev/null; then
    echo "❌ Ansible is niet geïnstalleerd"
    echo "📦 Installeer met: sudo xbps-install -y ansible"
    exit 1
fi

# Check of we root zijn (nodig voor installatie)
if [[ $EUID -ne 0 ]]; then
    echo "⚠️  Dit script moet als root draaien (sudo)"
    echo "Herstart met: sudo ./deploy.sh"
    exit 1
fi

# Install collections
echo "📦 Installeer benodigde collections..."
ansible-galaxy collection install -r requirements.yml

# Check of variabelen bestanden bestaan
if [[ ! -f "vars.yml" ]]; then
    echo "❌ vars.yml niet gevonden!"
    exit 1
fi

if [[ ! -f "secret.yml" ]]; then
    echo "❌ secret.yml niet gevonden!"
    echo "📝 Kopieer secret.example.yml naar secret.yml en vul aan"
    exit 1
fi

# Dry-run first (alleen check, geen wijzigingen)
echo "📋 Voer dry-run uit..."
ansible-playbook site.yml --check --diff

# Ask for confirmation
read -p "Wil je doorgaan met deployment op localhost? (j/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Jj]$ ]]; then
    echo "Deployment geannuleerd."
    exit 1
fi

# Run deployment (geen inventory nodig bij localhost)
echo "🚀 Start deployment op localhost..."
ansible-playbook site.yml --ask-vault-pass

# Check health (lokaal)
echo "🏥 Controleer service health..."
sleep 5

if command -v /usr/local/bin/health-check.sh &> /dev/null; then
    /usr/local/bin/health-check.sh
else
    echo "⚠️  Health check script nog niet beschikbaar"
    echo "🔍 Handmatige check:"
    sv status caddy php-fpm mattermost 2>/dev/null || true
fi

echo ""
echo "✅ Deployment compleet!"
echo "================================"
echo "📍 Website: http://localhost"
echo "🔧 Grav Admin: http://localhost/admin"
echo "💬 Mattermost: http://localhost/chat"
echo "📝 Logs: /var/log/"
echo ""
echo "🔐 Wachtwoorden staan in secret.yml"