# ANSIBLE INFRASTRUCTURE CONCEPT

## Architectuur Overzicht

### Visie
Een robuuste, schaalbare en veilige infrastructuur die alle applicaties kan huisvesten.

### Ontwerpprincipes
1. Abstractie - Hardware details lekken niet naar applicaties
2. Automatisering - Alles is code, alles is herbruikbaar
3. Security by design - In elke laag ingebakken
4. Testbaarheid - Elke verandering wordt getest
5. Documentatie - Kennis is vastgelegd, niet in hoofden

### Lagenmodel

| Laag | Verantwoordelijkheid | Technologie |
|------|---------------------|-------------|
| Applicatie | Bedrijfsfunctionaliteit | Docker containers |
| Orchestratie | Container management | Kubernetes / Docker Swarm |
| Container | Runtime isolatie | Docker Engine / containerd |
| OS | Basis services | Linux (5 families) |
| Hardware | Fysieke resources | Dell / Supermicro |
| Facilitair | Rack/stroom/koeling | Datacenter |

### Security zones

| VLAN | Naam | Doel |
|------|------|------|
| 10 | Management | Beheer toegang |
| 20 | DMZ | Publieke services |
| 30 | Applicatie | Backend services |
| 40 | Database | Gevoelige data |
| 50 | Storage | Opslag |
| 99 | Staging | Test omgeving |

---

## 1. INVENTORY LAAG

**Directories:**
- inventory/production/hosts.ini - Server lijst met groepen
- inventory/production/group_vars/all.yml - Variabelen voor ALLE servers
- inventory/production/group_vars/by_location/ams.yml - Datacenter Amsterdam
- inventory/production/group_vars/by_location/fra.yml - Datacenter Frankfurt
- inventory/production/group_vars/by_hardware/compute.yml - Compute nodes
- inventory/production/group_vars/by_hardware/storage.yml - Storage nodes
- inventory/production/group_vars/by_function/webservers.yml - Web servers
- inventory/production/group_vars/by_function/databases.yml - Databases
- inventory/production/host_vars/web01.yml - Specifiek voor web01
- inventory/production/host_vars/db01.yml - Specifiek voor db01
- inventory/production/network/vlans.yml - VLAN IDs en subnetten
- inventory/production/network/firewall.yml - Firewall regels

---

## 2. HARDWARE LAAG

**Assets:**
- hardware/assets/servers.yml - Alle fysieke servers met specs
- hardware/assets/switches.yml - Netwerk switches
- hardware/assets/pdus.yml - Power distribution units

**Locations:**
- hardware/locations/racks.yml - Rack layout per locatie
- hardware/locations/datacenters.yml - Datacenter info

**Monitoring:**
- hardware/monitoring/ipmi.yml - Out-of-band management
- hardware/monitoring/sensors.yml - Temperatuur, fans, voltages

---

## 3. PLATFORM LAAG

**Operating Systems:**
- platform/os/Debian/main.yml - apt, package names, service names
- platform/os/RedHat/main.yml - dnf/yum, selinux, firewalld
- platform/os/Suse/main.yml - zypper, SuSEfirewall2
- platform/os/Archlinux/main.yml - pacman, systemd
- platform/os/Alpine/main.yml - apk, openrc

**Virtualization:**
- platform/virtualization/proxmox.yml - Proxmox cluster config
- platform/virtualization/vmware.yml - vCenter/ESXi config

**Networking:**
- platform/networking/bonding.yml - LACP bonding modes
- platform/networking/interfaces.yml - Netwerk interface templates

---

## 4. CONTAINER LAAG

**Runtime:**
- containers/runtime/docker.yml - Docker daemon config
- containers/runtime/containerd.yml - Containerd config

**Networking:**
- containers/networking/cni.yml - Container network interface
- containers/networking/docker-networks.yml - Docker netwerken

**Storage:**
- containers/storage/volumes.yml - Docker volumes
- containers/storage/csi.yml - Container storage interface

---

## 5. ORCHESTRATIE LAAG

**Kubernetes:**
- orchestration/kubernetes/cluster.yml - K8s cluster config
- orchestration/kubernetes/nodes.yml - Master/worker nodes
- orchestration/kubernetes/addons.yml - Ingress, monitoring, logging

**Docker Swarm:**
- orchestration/docker-swarm/init.yml - Swarm initialisatie
- orchestration/docker-swarm/services.yml - Swarm services

---

## 6. APPLICATIE LAAG

**Definitions:**
- applications/definitions/nextcloud.yml - Nextcloud stack
- applications/definitions/homeassistant.yml - Home Assistant
- applications/definitions/postgresql.yml - PostgreSQL database
- applications/definitions/redis.yml - Redis cache
- applications/definitions/nginx.yml - Nginx webserver

**Secrets:**
- applications/secrets/vault/README.md - Ansible Vault gebruik

**Backups:**
- applications/backups/strategies.yml - Backup schema per app

---

## 7. SECURITY LAAG

**Hardening:**
- security/hardening/ssh.yml - SSH hardening
- security/hardening/kernel.yml - Kernel parameters

**Network:**
- security/network/firewall.yml - Firewall policies

**Container:**
- security/container/docker-bench.yml - Docker security checks

**Compliance:**
- security/compliance/cis-benchmarks.yml - CIS standards per OS

---

## 8. MONITORING LAAG

**Metrics:**
- monitoring/metrics/prometheus.yml - Prometheus config
- monitoring/metrics/exporters.yml - Node exporter, cadvisor

**Logging:**
- monitoring/logging/loki.yml - Loki logging
- monitoring/logging/vector.yml - Vector aggregator

**Alerts:**
- monitoring/alerts/alertmanager.yml - Alert routing

---

## 9. TEST LAAG

- testing/molecule/default/molecule.yml - Molecule test config
- testing/molecule/scenarios/upgrade.yml - Upgrade test scenario

---

## 10. DOCUMENTATIE

**Architecture:**
- docs/architecture/overview.md - Architectuur beslissingen

**Runbooks:**
- docs/runbooks/server-down.md - Stappen bij server uitval
- docs/runbooks/app-deploy.md - Nieuwe app deployen

**Quickstart:**
- docs/quickstart/README.md - Voor nieuwe teamleden

---

## 11. PLAYBOOKS

- playbooks/site.yml - Complete site config
- playbooks/deploy-app.yml - Applicatie deploy
- playbooks/security.yml - Security hardening

---

## 12. ROLES

**Base:**
- roles/base/tasks/main.yml - Basis configuratie
- roles/base/vars/main.yml - OS-specifieke packages

**Docker:**
- roles/docker/tasks/main.yml - Docker installatie
- roles/docker/templates/daemon.json.j2 - Docker daemon template

**Application:**
- roles/application/tasks/main.yml - Applicatie deploy
- roles/application/templates/compose.yml.j2 - Docker compose template

---

## 13. ROOT BESTANDEN

- ansible.cfg - Ansible globale config
- requirements.yml - Collections en roles
- .gitignore - Wat niet in git
