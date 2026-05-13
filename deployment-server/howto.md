# Systeemontwerp: Full Deployment Server
**Platform:** Debian 13 (Trixie) | **Core:** DRBL 5.4.10-1 & Clonezilla

---

## 1. Netwerkarchitectuur
De server fungeert als een gateway tussen het bedrijfsnetwerk (WAN) en het afgeschermde installatienetwerk (LAN).

### Interface Configuratie
*   **Upstream (Internet/WAN):** 
    - Dynamisch IP via DHCP.
    - Functie: Ophalen van pakketten, updates en Docker/Git repo's.
*   **Internal (Deployment LAN):**
    - Statisch IP: `10.10.10.1/24`.
    - Functie: Volledige controle over het netwerk voor PXE-booting.
    - Verkeer: DHCP, TFTP, NFS en Apt-Cacher.



---

## 2. Server Componenten (The Stack)

### A. Boot & Provisioning
| Service | Tool | Beschrijving |
| :--- | :--- | :--- |
| **DHCP** | `isc-dhcp-server` | Deelt IP's uit en verwijst clients naar de bootloader via Option 67. |
| **TFTP** | `tftpd-hpa` | Serveert de PXE-bootloaders (`pxelinux.0` en `netboot.xyz.efi`). |
| **Boot Menu** | `netboot.xyz` | Maakt het mogelijk om diverse Linux-distributies direct via internet/netwerk te installeren. |

### B. Imaging & Data
| Service | Tool | Beschrijving |
| :--- | :--- | :--- |
| **Deployment** | `DRBL` | Beheert de diskless omgeving voor de clients. |
| **Imaging** | `Clonezilla` | De engine voor het maken en terugzetten van harde schijf images. |
| **Storage** | `NFS` | De schijfruimte op `/home/partimag` waar images centraal worden opgeslagen. |

### C. Optimalisatie & Management
| Service | Tool | Beschrijving |
| :--- | :--- | :--- |
| **Caching** | `Apt-Cacher-NG` | Slaat gedownloade `.deb` pakketten lokaal op (poort 3142) om bandbreedte te besparen. |
| **Web GUI** | `Cockpit` | Webinterface (poort 9090) voor monitoring en beheer. |
| **Gezondheid** | `Smartmontools` | Actieve monitoring van de harde schijf status (S.M.A.R.T.). |

---

## 3. Procesflow (Client Boot)

1.  **Aanvraag:** Client start op via PXE en vraagt een IP-adres aan op het interne LAN.
2.  **Toewijzing:** Server geeft IP en wijst naar de TFTP-server (`10.10.10.1`).
3.  **Laden:** Client downloadt de bootloader en toont het Clonezilla/DRBL menu.
4.  **Uitvoering:** De client mount de image-folder via **NFS** en begint met het schrijven van de data naar de lokale disk.
5.  **Caching:** Tijdens installatie van extra software worden pakketten via de **Apt-Cacher** opgehaald.



---

## 4. Beveiliging & Routing
*   **Firewall (UFW):**
    - Inkomend op WAN: Alleen SSH (22).
    - Inkomend op LAN: DHCP, TFTP, NFS, Cockpit en Apt-Cacher toegestaan.
*   **NAT (IP Forwarding):** 
    - De server routeert verkeer van de clients naar het internet via *Masquerading*, zodat clients updates kunnen ophalen zonder directe WAN-toegang.

---

## 5. Opslagstructuur
*   `/home/partimag`: Centrale opslag voor alle Clonezilla images.
*   `/var/cache/apt-cacher-ng`: Opslag voor gecachte softwarepakketten.
*   `/srv/tftp`: Root directory voor alle netwerk-boot bestanden.


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