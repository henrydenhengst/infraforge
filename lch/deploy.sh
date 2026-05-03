#!/bin/bash
# Deployment script voor Linux Café Haarlem

set -e

echo "🚀 Start deployment Linux Café Haarlem"
echo "================================"

# Check prerequisites
if ! command -v ansible-playbook &> /dev/null; then
    echo "❌ Ansible is niet geïnstalleerd"
    exit 1
fi

# Install collections
echo "📦 Installer benodigde collections..."
ansible-galaxy collection install -r requirements.yml

# Test connectivity
echo "🔍 Test verbinding met target host..."
ansible all -m ping -i inventory.yml

# Dry-run first
echo "📋 Voer dry-run uit..."
ansible-playbook site.yml --check --diff -i inventory.yml

# Ask for confirmation
read -p "Wil je doorgaan met deployment? (j/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Jj]$ ]]; then
    echo "Deployment geannuleerd."
    exit 1
fi

# Run deployment
echo "🚀 Start deployment..."
ansible-playbook site.yml --ask-vault-pass -i inventory.yml

# Check health
echo "🏥 Controleer service health..."
sleep 5
ansible linuxcafe -m command -a "/usr/local/bin/health-check.sh" -i inventory.yml

echo "✅ Deployment compleet!"
echo "📍 Website: https://{{ duckdns_domain }}.duckdns.org"