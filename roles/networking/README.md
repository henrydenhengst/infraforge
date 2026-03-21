# Networking Role

## Beschrijving
Deze role configureert netwerk interfaces, bonding, VLANs en DNS.

## Wat doet deze role?
- Installeert netwerk packages per OS
- Configureert netwerk interfaces (static/DHCP)
- Configureert bonding (LACP) voor redundantie
- Configureert VLANs
- Configureert DNS (/etc/resolv.conf)
- Configureert hostname resolutie (/etc/hosts)
- Stelt sysctl parameters in voor netwerk performance
- Valideert netwerk connectiviteit

## Variabelen
| Variabele | Default | Beschrijving |
|-----------|---------|--------------|
| dns_servers | [1.1.1.1, 8.8.8.8] | DNS servers |
| dns_search | company.local | DNS search domain |
| network_bonding_enabled | false | Bonding inschakelen |
| network_bonding_mode | 4 | Bonding mode (LACP) |
| network_vlans | [] | VLAN configuratie |
| network_interfaces | [] | Interface configuratie |
| hostname | inventory_hostname | Systeem hostname |
| domain | company.local | DNS domain |
| mtu | 1500 | MTU waarde |

## Tags
- `packages` - Alleen packages installeren
- `interfaces` - Alleen interfaces configureren
- `bonding` - Alleen bonding configureren
- `vlans` - Alleen VLANs configureren
- `dns` - Alleen DNS configureren
- `hosts` - Alleen /etc/hosts configureren
- `sysctl` - Alleen sysctl parameters
- `services` - Alleen services starten
- `validate` - Alleen validatie
