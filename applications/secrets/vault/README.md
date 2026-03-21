# Ansible Vault Secrets

Deze directory bevat versleutelde secrets voor alle applicaties.

## Encryptie

Gebruik Ansible Vault voor alle gevoelige data:

```bash
# Nieuw secret bestand aanmaken
ansible-vault create applications/secrets/vault/database.yml

# Bestand bewerken
ansible-vault edit applications/secrets/vault/database.yml

# Bestand bekijken (alleen voor controle)
ansible-vault view applications/secrets/vault/database.yml
