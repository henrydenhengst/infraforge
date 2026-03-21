# Hardware Architectuur

## Overzicht

Onze hardware infrastructuur bestaat uit drie lagen:
- **Compute nodes** - Voor applicaties en processing
- **Storage nodes** - Voor data persistentie
- **Network nodes** - Voor connectiviteit

## Compute Nodes

| Model | CPU | RAM | Storage | Netwerk |
|-------|-----|-----|---------|---------|
| Dell PowerEdge R760 | 2x Intel Xeon Gold 32 cores | 512GB DDR5 | 2x 480GB SSD (OS) + 4x 1.9TB NVMe | 2x 25GbE |

## Storage Nodes

| Model | CPU | RAM | Storage | Netwerk |
|-------|-----|-----|---------|---------|
| Dell PowerVault ME5084 | 2x Intel Xeon Silver | 128GB | 24x 20TB HDD + 4x 1.9TB SSD cache | 2x 25GbE |

## Network

- Cisco Nexus 9300 series
- Spine-leaf architectuur
- 100GbE spine, 25GbE leaf
- VXLAN voor overlay

## Redundantie

- N+1 voeding in alle servers
- Dubbele switches (spine en leaf)
- LACP bonding naar alle servers
- RAID voor data bescherming
- Batterij-backed cache controllers

## Monitoring

Elke server heeft:
- IPMI/iDRAC out-of-band management
- Hardware sensoren (temp, fans, voltage)
- SNMP voor netwerk apparatuur
- Redfish API voor moderne monitoring

## Lifecycle

1. **Procurement** (30 dagen lead time)
2. **Deployment** (4 uur per server)
3. **Production** (3-5 jaar)
4. **Decommissioning** (5 dagen)
