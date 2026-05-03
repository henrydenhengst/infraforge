# Void Linux Server - Full Stack Ansible

Installeert en configureert op localhost: Caddy, Grav CMS, IPFS node, Syncthing relay, Nostr relay, Tor Snowflake.

📁 Bestandsstructuur

```
linuxcafehaarlem/
├── site.yml
├── vars.yml
├── secret.yml (ge-encrypt met ansible-vault)
├── requirements.yml
├── templates/
│   ├── Caddyfile.j2
│   ├── grav-config.php.j2
│   ├── nostr-relay.conf.j2
│   ├── syncthing-relay.env.j2
│   ├── tor-snowflake.env.j2
│   ├── ipfs.service.j2
│   ├── 99-ipfs.conf.j2
│   ├── ufw-before.rules.j2
│   ├── fail2ban-jail.local.j2
│   └── sshd_config.j2
└── README.md
```

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