# BUSINESS CASE: IMPLEMENTATIE STATELESS INFRASTRUCTUUR EN ZERO-TOUCH DESKTOP PROVISIONING

## 1. STRATEGISCHE CONTEXT
De huidige markt vraagt om een drastische verkorting van de 'Time-to-Market' voor software-ontwikkeling. Traditioneel werkplekbeheer (individueel beheerde OS-installaties) vormt hierbij een bottleneck door 'configuration drift', handmatig onderhoud en beveiligingsrisico's. 

Dit voorstel behelst de transitie naar een centraal aangestuurde, stateless infrastructuur voor 25 programmeurs, gebaseerd op het InfraForge-framework en een gelaagde Linux Desktop Provisioning (PLD).

---

## 2. TECHNISCHE ARCHITECTUUR: HET MASTER-NODE CONCEPT
Centraal in dit model staat een high-end on-premise compute-node (investring ca. € 100.000,-). Deze node fungeert niet als een passieve opslag, maar als de actieve 'Control Plane' voor de gehele vloot.

### 2.1 Gelaagde Provisioning (L0 t/m Functie C)
In plaats van statische images, bouwt elke Fat Client zijn systeem modulair op bij elke boot-cyclus:
* **L0 - OS Bootstrapping:** Gebruik van PXE-boot voor netwerk-initiatie. De client start een schone kernel (Debian/NixOS/Ubuntu) zonder lokale schijfafhankelijkheid.
* **L1 - Hygiëne & User Management:** Directe afdwinging van centrale authenticatie, SSH-keys en de 'PLD-reset' die lokale tijdelijke data wist voor een gegarandeerde schone start.
* **L2 - Hardware Abstractie:** Automatische detectie van hardware-ID's en on-the-fly injectie van specifieke drivers (NVIDIA/AMD GPU, CPU microcode).
* **Interface-laag:** De uitrol van de grafische schil (KDE/Gnome) op basis van centrale configuratie in plaats van lokale voorkeuren.
* **Functie C - Applicatie-stack:** Specifieke software-sets (bijv. Docker, Kubernetes-tools, compilers) worden als finale laag gepusht op basis van de functiegroep van de medewerker.

### 2.2 InfraForge Engine
De backend wordt beheerd via de InfraForge-repository, die de volgende componenten bevat:
* **70 Ansible Roles:** Volledig gedocumenteerde rollen voor OS-hardening, monitoring (Prometheus/Grafana), en back-up (Rclone/Rsync).
* **310 Applicatiedefinities:** Een bibliotheek van container-gebaseerde services die direct inzetbaar zijn op zowel desktops als servers.
* **OS-Agnostisch Beheer:** Ondersteuning voor de 5 belangrijkste Linux-families (Debian, RedHat, SUSE, Arch, Alpine).

---

## 3. OPERATIONELE VOORDELEN
### 3.1 Self-Healing Infrastructure
Door de stateless natuur van de PLD-targets is elke machine bij een herstart weer in de 'Golden State'. Foutieve configuraties door de gebruiker worden geëlimineerd zonder tussenkomst van een systeembeheerder.

### 3.2 GitOps-gedreven Beheer
Wijzigingen aan de vloot (software-updates, security-patches of nieuwe gebruikers) worden doorgevoerd via wijzigingen in de centrale Git-repository. Zodra de code gepusht is, synchroniseert de gehele vloot zich automatisch via de Ansible-engine.

### 3.3 Lokale Rekenkracht (DeepSeek Integratie)
De investering in GPU-hardware op de master-node faciliteert een lokaal LLM-endpoint (DeepSeek-Coder-V2). Dit biedt programmeurs geavanceerde assistentie bij complexe taken (zoals het genereren van Ansible-playbooks) zonder dat intellectueel eigendom de interne infrastructuur verlaat.

---

## 4. FINANCIËLE ANALYSE (TCO & ROI)
### 4.1 Investeringskosten (Jaar 1)
| Post | Omschrijving | Bedrag |
| :--- | :--- | :--- |
| **Hardware** | Master-node (4x RTX 6000 Ada, Threadripper Pro, 512GB RAM) | € 60.000 |
| **Provisioning Setup** | Inrichting PXE, GitOps pipeline en InfraForge integratie | € 10.000 |
| **Training** | Kennisoverdracht m.b.t. PLD-workflow en IaC-methodiek | € 30.000 |
| **TOTAAL** | | **€ 100.000** |

### 4.2 Besparingen (Jaarbasis)
* **Reductie Systeembeheer:** Door de zero-touch benadering vervalt de noodzaak voor handmatig werkplekbeheer. Besparing geschat op 0,5 FTE (€ 45.000,-).
* **Productiviteitswinst Developers:** De combinatie van gestandaardiseerde omgevingen en lokale AI-ondersteuning leidt tot een conservatieve efficiëntieverbetering van 25%. Op een loonsom van € 2.000.000,- (25 man) vertegenwoordigt dit een waarde van € 500.000,-.
* **Onboarding & Downtime:** Terugbrengen van onboarding-tijd van 2 dagen naar 15 minuten per nieuwe medewerker.

### 4.3 Terugverdientijd
De investering van € 100.000,- wordt bij een team van 25 personen binnen **4 tot 5 maanden** volledig terugverdiend door de directe daling van de operationele kosten en stijging van de output.

---

## 5. RISICO-ANALYSE EN MITIGATIE
* **Netwerkafhankelijkheid:** Aangezien de provisioning via PXE verloopt, is een redundant 10Gbps netwerk vereist. Dit is meegenomen in de hardware-begroting.
* **Vendor Lock-in:** Nihil. De volledige stack is gebaseerd op Open Source standaarden (Linux, Ansible, Git).
* **Data-integriteit:** Door de 'Headless by Default' opzet en gecentraliseerde logging (Loki/Tempo) is er maximale controle over systeem-integriteit en security-audits.

---

## 6. CONCLUSIE
De implementatie van deze infrastructuur is geen IT-upgrade, maar een fundamentele herziening van de operationele slagkracht. Door hardware-kracht te koppelen aan de deterministische provisioning van InfraForge en PLD, wordt een omgeving gecreëerd die schaalbaar, veilig en nagenoeg onderhoudsvrij is.

**Bijlage:** Technisch Runbook en Ansible-inventarisatie (InfraForge Repository).
