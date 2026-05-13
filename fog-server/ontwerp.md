# Ontwerpdocument: FOG Imaging Appliance (Linux Cafe Haarlem Editie)

## 1. Doel van het Systeem
Dit systeem is ontworpen als een robuuste, reproduceerbare imaging-server voor het **Laptop Revive** project. Het doel is om op grote schaal Linux Mint te installeren op gedoneerde laptops voor studenten, gebruikmakend van enterprise-grade automatisering op basis van **AlmaLinux 10**.

## 2. Hardware Architectuur
*   **Basisstation:** Fujitsu Esprimo E900.
*   **Netwerk:** Intel Quad-Port NIC (4 poorten).
    *   **Configuratie:** Network Bonding (Mode 5 - Adaptive Transmit Load Balancing).
    *   **Voordeel:** Combineert de bandbreedte van 4 poorten voor imaging-verkeer zonder dat er complexe switch-instellingen nodig zijn.
*   **Opslag:** Toegewezen SSD voor images, gekoppeld via een unieke UUID voor maximale stabiliteit tijdens het mounten.

## 3. Software Stack & Automatisering
Het volledige systeem wordt beheerd via **Ansible** (Infrastructure as Code), wat zorgt voor een foutloze en identieke herinstallatie.

### Belangrijkste Componenten:
*   **Besturingssysteem:** AlmaLinux 10 (Enterprise Linux).
*   **Imaging Software:** FOG Project (Versie 1.6.0).
*   **Webserver & Database:** PHP 8.3 en MariaDB (beveiligd met sterke wachtwoorden).
*   **Protocollen:**
    *   **PXE (TFTP):** Voor het opstarten van laptops via het netwerk.
    *   **NFSv4:** Voor het razendsnel overdragen van schijf-images (getuned met 16 threads).

## 4. Beveiliging & Operational Excellence
*   **SELinux:** Actief in 'Targeted' modus met specifieke uitzonderingen voor HTTP en NFS verkeer.
*   **Firewall:** Strikt geconfigureerd op poortniveau; alleen noodzakelijke poorten voor imaging (HTTP, TFTP, NFS, RPC) zijn geopend.
*   **Digital Sovereignty:** Volledig opgebouwd uit open-source componenten, passend bij de visie van het **Linux Café Haarlem**.
*   **Idempotentie:** Het systeem kan herhaaldelijk worden geconfigureerd zonder dat bestaande instellingen corrupt raken.

## 5. Workflow bij Uitrol
1.  **Laptops koppelen:** De client-laptops worden verbonden met het dedicated imaging-VLAN.
2.  **PXE Boot:** Laptops starten op via de Intel Quad-NIC van de server.
3.  **Deployment:** Linux Mint images worden via de getunede NFS-stack gelijktijdig naar meerdere laptops gepusht.
4.  **Lifecycle:** Logs worden centraal bijgehouden in `/var/log/fog_install.log` voor onderhoud en troubleshooting.

---
*Henry den Hengst / Linux Cafe Haarlem (Mei 2026)*
