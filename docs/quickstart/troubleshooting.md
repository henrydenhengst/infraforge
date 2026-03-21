# Troubleshooting

Probleem: Kan geen verbinding maken met server
Oplossing:
  ssh -i ~/.ssh/id_ed25519 ansible@server
  ansible -i inventory/production/hosts.ini server -m ping

Probleem: Playbook faalt met "Permission denied"
Oplossing:
  ansible -i inventory/production/hosts.ini server -m shell -a "sudo whoami"

Probleem: Docker container start niet
Oplossing:
  docker logs container-naam
  docker ps -a

Probleem: Database connectie mislukt
Oplossing:
  systemctl status postgresql
  psql -U postgres -h localhost
