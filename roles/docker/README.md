# Docker Role

## Beschrijving
Deze role installeert en configureert Docker Engine en Docker Compose.

## Wat doet deze role?
- Installeert Docker prerequisites per OS
- Voegt officiële Docker repository toe
- Installeert Docker Engine, CLI, containerd, buildx en compose plugin
- Start en enable Docker service
- Voegt ansible gebruiker toe aan docker groep
- Configureert Docker daemon (log driver, storage driver, etc.)
- Installeert Docker Python module voor Ansible
- Configureert logrotate voor Docker logs
- Security hardening (AppArmor/SELinux configuratie)

## Variabelen
| Variabele | Default | Beschrijving |
|-----------|---------|--------------|
| docker_daemon_config | zie defaults | Docker daemon configuratie |
| add_user_to_docker_group | true | Voeg gebruiker toe aan docker groep |
| docker_version | latest | Docker versie |
| package_cache_update | true | Update package cache voor installatie |

## Tags
- `prerequisites` - Alleen prerequisites installeren
- `repository` - Alleen repository toevoegen
- `install` - Alleen packages installeren
- `service` - Alleen service configuratie
- `compose` - Alleen Docker Compose installatie
- `user` - Alleen gebruiker toevoegen aan docker groep
- `config` - Alleen daemon configuratie
- `python` - Alleen Python module installatie
- `logging` - Alleen logrotate configuratie
- `security` - Alleen security hardening
