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

# Automatisch naar de laatste backup
ansible-playbook 03_rollback.yml --ask-become-pass

# OF expliciet een backup kiezen
ansible-playbook 03_rollback.yml --ask-become-pass -e "BACKUP_DIR=/root/deployment_backups/1747215000"

```