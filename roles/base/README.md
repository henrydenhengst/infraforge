# Base Role

## Beschrijving
Deze role zorgt voor een consistente basisconfiguratie op alle servers.

## Wat doet deze role?
- Update package cache en security updates
- Installeert basis packages (curl, wget, git, vim, htop, etc.)
- Configureert hostname en /etc/hosts
- Installeert en configureert NTP (chrony)
- Stelt tijdzone in (Europe/Amsterdam)
- Configureert locale (nl_NL.UTF-8)
- Maakt ansible gebruiker aan met sudo rechten
- Stelt kernel parameters in
- Configureert ulimits

## Variabelen
| Variabele | Default | Beschrijving |
|-----------|---------|--------------|
| timezone | Europe/Amsterdam | Systeem tijdzone |
| security_updates | true | Security updates automatisch installeren |
| create_ansible_user | true | Ansible gebruiker aanmaken |
| ansible_user_groups | sudo,wheel | Groepen voor ansible gebruiker |

## Tags
- `packages` - Alleen package installatie
- `security` - Alleen security updates
- `hostname` - Alleen hostname configuratie
- `ntp` - Alleen NTP configuratie
- `timezone` - Alleen tijdzone configuratie
- `locale` - Alleen locale configuratie
- `user` - Alleen gebruiker configuratie
- `kernel` - Alleen kernel parameters
- `limits` - Alleen ulimits configuratie
- `always` - Altijd uitvoeren
