# Security Role

## Beschrijving
Deze role zorgt voor security hardening op alle servers, gebaseerd op CIS benchmarks.

## Wat doet deze role?
- Installeert security packages (fail2ban, firewall, auditd, etc.)
- SSH hardening (poort, authenticatie, ciphers)
- Firewall configuratie (UFW, firewalld, iptables)
- Fail2ban configuratie voor brute-force bescherming
- Kernel parameter hardening
- Auditd configuratie voor logging
- Automatic security updates
- Uitschakelen van ongewenste services
- Password policy configuratie

## Variabelen
| Variabele | Default | Beschrijving |
|-----------|---------|--------------|
| ssh_port | 22 | SSH poort |
| ssh_permit_root_login | no | Root login via SSH toestaan |
| ssh_password_authentication | no | Password authenticatie |
| fail2ban_enabled | true | Fail2ban inschakelen |
| fail2ban_bantime | 3600 | Ban tijd (seconden) |
| firewall_enabled | true | Firewall inschakelen |
| automatic_updates | true | Automatic updates inschakelen |

## Tags
- `packages` - Alleen security packages installeren
- `ssh` - Alleen SSH configuratie
- `firewall` - Alleen firewall configuratie
- `fail2ban` - Alleen fail2ban configuratie
- `kernel` - Alleen kernel parameters
- `audit` - Alleen auditd configuratie
- `updates` - Alleen automatic updates
- `services` - Alleen services uitschakelen
- `sudo` - Alleen sudo configuratie
- `motd` - Alleen MOTD configuratie
