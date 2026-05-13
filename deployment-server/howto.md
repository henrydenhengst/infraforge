```
deployment_server/
├── ansible.cfg
├── .gitignore
├── 01_detect_and_setup_network.yml
├── 02_full_deployment_server.yml
├── 03_rollback.yml
└── templates/
    └── drbl_answer_30.j2

# Stap 1: Detecteer NICs
ansible-playbook 01_detect_and_setup_network.yml --ask-become-pass

# Stap 2: Volledige installatie
ansible-playbook 02_full_deployment_server.yml --ask-become-pass

# Controleer
cat /etc/deployment_server_ready

# Rollback (indien nodig)
ansible-playbook 03_rollback.yml --ask-become-pass -e "BACKUP_DIR=/root/deployment_backups/1234567890"

```