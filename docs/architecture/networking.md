# Netwerk Architectuur

## VLAN Indeling

| VLAN | Naam | Subnet | Doel |
|------|------|--------|------|
| 10 | Management | 10.10.10.0/24 | Beheer toegang (SSH, monitoring) |
| 20 | DMZ | 10.10.20.0/24 | Publieke services (web, API) |
| 30 | Applicatie | 10.10.30.0/24 | Backend services |
| 40 | Database | 10.10.40.0/24 | Databases en gevoelige data |
| 50 | Storage | 10.10.50.0/24 | Opslag (backups, NAS) |
| 99 | Staging | 10.10.99.0/24 | Test omgeving |

## Firewall Policies

| Zone | Regel | Toegang |
|------|-------|---------|
| Management | SSH | Alleen management subnet |
| DMZ | HTTP/HTTPS | Vanuit internet |
| Applicatie | API | Alleen van DMZ |
| Database | Database poorten | Alleen van Applicatie |
| Storage | NFS/iSCSI | Alleen van Applicatie |

## Bonding (LACP)

- Mode 4 (802.3ad) voor LACP
- Miimon 100 voor link monitoring
- Lacp_rate fast voor snelle failover
- Xmit_hash_policy layer3+4 voor load balancing

## DNS

- Interne DNS: consul
- Externe DNS: Cloudflare
- Search domain: company.local
