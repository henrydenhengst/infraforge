# Ansible Infrastructuur

Dit is de Infrastructure-as-Code repository voor onze complete omgeving.

## Snelstart
```bash
# Installeer dependencies
ansible-galaxy collection install -r requirements.yml

# Test connectiviteit
ansible all -m ping -i inventory/production/hosts.ini
```
