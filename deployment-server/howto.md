```bash
# Stap 1: Detecteer NICs en valideer configuratie
ansible-playbook 01_detect_and_setup_network.yml --ask-become-pass -v

# Stap 2: Volledige installatie met health checks
ansible-playbook 02_full_deployment_server.yml --ask-become-pass -v

# Optioneel: Toon deployment status
cat /etc/deployment_server_ready

# Optioneel: Test PXE boot (vanaf client)
# Zet een client in PXE boot modus op het interne netwerk

# Rollback indien nodig
ansible-playbook 03_rollback.yml --ask-become-pass -e "BACKUP_DIR=/root/deployment_backups/1734567890"
```