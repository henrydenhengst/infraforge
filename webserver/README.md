# Void Linux Server - Full Stack Ansible

Installeert en configureert op localhost: Caddy, Grav CMS, IPFS node, Syncthing relay, Nostr relay, Tor Snowflake.


## Vereisten
- Void Linux (fresh install)
- DuckDNS account en subdomein

## Installatie
```bash
git clone <repo>
cd ansible-void-server
cp secret.example.yml secret.yml
ansible-vault encrypt secret.yml
sudo ansible-playbook site.yml --ask-vault-pass
```