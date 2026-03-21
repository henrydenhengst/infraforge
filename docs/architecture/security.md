# Security Architectuur

## Security by Design

1. **Network segmentation** - VLANs isoleren services
2. **Least privilege** - Minimale rechten voor gebruikers en services
3. **Defense in depth** - Meerdere beveiligingslagen
4. **Zero trust** - Geen impliciet vertrouwen
5. **Audit trails** - Alle acties worden gelogd

## Authenticatie

| Service | Authenticatie | 2FA |
|---------|---------------|-----|
| SSH | Publieke sleutel | N.v.t. |
| GitLab | OAuth / LDAP | Optioneel |
| Nextcloud | OAuth / LDAP | Verplicht |
| Grafana | OAuth / LDAP | Verplicht |
| VPN | Certificaten | N.v.t. |

## Firewall

- **Ingress**: Alleen noodzakelijke poorten
- **Egress**: Beperkt tot updates en DNS
- **Rate limiting**: 100 requests/sec per IP
- **Fail2ban**: 5 mislukte pogingen = 1 uur ban

## Hardening

- **OS**: CIS benchmarks
- **SSH**: Geen root login, alleen sleutels
- **Docker**: Non-root user, seccomp profiles
- **Kubernetes**: RBAC, network policies
- **TLS**: Versie 1.3, strong ciphers

## Monitoring

- **Wazuh**: EDR/XDR voor endpoint monitoring
- **Falco**: Runtime security
- **Auditd**: System call logging
- **Fail2ban**: Brute force detectie
