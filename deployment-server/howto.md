```
deployment_server/
├── main.yml                    ← Alles in één!
├── ansible.cfg
├── .gitignore
├── 03_rollback.yml             ← Optioneel, voor noodgevallen
└── templates/
    └── drbl_answer_30.j2


# Alles in één keer
ansible-playbook main.yml --ask-become-pass

# Controleer
cat /etc/deployment_server_ready

# Rollback (indien nodig)
ansible-playbook 03_rollback.yml --ask-become-pass -e "BACKUP_DIR=/root/deployment_backups/1234567890"

```