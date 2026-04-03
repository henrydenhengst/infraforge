# INVESTERINGSVOORSTEL: AUTONOME SOFTWARE FACTORY & STATELESS VLOOTBEHEER
**Projectcode:** INFRAFORGE-2026-01
**Investering:** € 100.000,- (CAPEX/OPEX Jaar 1)
**Doelgroep:** 25 FTE Software Engineering

---

## 1. STRATEGISCHE SAMENVATTING
Dit voorstel breekt met de traditionele methode van individueel werkplekbeheer. Door de implementatie van een 'Master-Node' architectuur transformeren we de IT-infrastructuur naar een stateless model. Hierbij wordt gebruikgemaakt van de InfraForge-methodiek en on-premise AI-inference (DeepSeek-Coder-V2) om de operationele snelheid te verhogen en de beheerslast te minimaliseren naar nagenoeg nul.

---

## 2. TECHNISCHE ARCHITECTUUR: DE "ZERO-TOUCH" METHODIEK

### 2.1 Stateless Provisioning Linux Desktops (PLD)
Traditionele laptops lijden aan 'configuration drift': ze worden traag, vervuilen en vertonen onverklaarbare fouten. Onze oplossing hanteert het stateless model van Henry den Hengst:

* **L0 - Netwerk Bootstrapping (PXE):** Geen lokale OS-installaties. De hardware start kaal op en laadt de kernel direct van de Master-Node.
* **L1 - De "PLD-Reset":** Bij elke herstart wordt de machine gewist en gesynchroniseerd met de 'Golden Image'. Dit garandeert een 100% schone en veilige start, elke dag opnieuw.
* **L2 - Dynamische Hardware-Abstractie:** De Master-Node herkent de specifieke componenten (NVIDIA/AMD) van het werkstation en injecteert on-the-fly de juiste drivers en firmware.
* **Functie C - Rolgebaseerde Applicatie-uitrol:** Via Ansible worden de benodigde toolchains (Docker, Kubernetes, compilers) gepusht op basis van de projectgroep.

### 2.2 De InfraForge Engine (Infrastructure-as-Code)
De ruggengraat van de operatie is de InfraForge-repository, die de volledige omgeving definieert als code:
* **70 Gevalideerde Ansible Roles:** Voor o.a. CIS-benchmarking (security), monitoring (Prometheus/Grafana) en centrale logging.
* **310 Applicatiedefinities:** Gestandaardiseerde Docker/Kubernetes stacks die direct inzetbaar zijn voor development en productie.
* **Multi-Distro Support:** Volledige ondersteuning voor Debian, RedHat, SUSE, Arch en Alpine, waardoor we niet gebonden zijn aan één leverancier.

---

## 3. ON-PREMISE AI: DE NOODZAAK VAN DATA-SOEVEREINITEIT

Het lokaal hosten van een DeepSeek-Coder-V2 model (236B parameters) op 4x RTX 6000 Ada GPU's is een strategische keuze voor IP-bescherming.

### 3.1 Intellectueel Eigendom & Compliance
Het versturen van broncode naar publieke AI-cloudproviders (SaaS) is een structureel risico. 
* **100% Privacy:** Geen enkele regel code verlaat de interne infrastructuur. Dit elimineert risico's op IP-diefstal en voldoet aan de strengste privacy-eisen (ISO 27001/AVG).
* **Onbeperkte Context:** Door lokaal 192GB VRAM beschikbaar te hebben, kan de AI volledige interne repositories analyseren (RAG), wat bij publieke providers onbetaalbaar of technisch onmogelijk is.

### 3.2 Diepe Integratie met InfraForge
De lokale AI wordt gevoed met de eigen InfraForge-documentatie en Ansible-rollen. Resultaat: de AI genereert code die *direct* werkt binnen onze specifieke infrastructuur, conform onze eigen standaarden.

---

## 4. FINANCIËLE ANALYSE & ROI

### 4.1 Investeringsbegroting (Jaar 1)
| Post | Omschrijving | Investering |
| :--- | :--- | :--- |
| **Hardware** | Master-Node (4x RTX 6000 Ada, Threadripper 32-core, 512GB RAM, 10GbE) | € 60.000 |
| **Engineering** | Setup PXE-stack, GitOps-pipelines en InfraForge-integratie | € 10.000 |
| **Training** | Mastery-traject voor 25 devs (Stateless workflow & AI-pairing) | € 30.000 |
| **Totaal** | | **€ 100.000** |

### 4.2 Jaarlijkse Besparingen (Conservatieve schatting)
1.  **Reductie Werkplekbeheer (PLD):** De 'Self-Healing' natuur van de vloot elimineert 80% van de support-tickets. Besparing: **€ 45.000,-**.
2.  **Productiviteitswinst (AI + IaC):** Een efficiëntieverbetering van 25% op de output van 25 developers (loonsom € 2M). Waarde: **€ 500.000,-**.
3.  **Eliminatie SaaS & Licenties:** Vervanging van AI-abonnementen en legacy beheer-software. Besparing: **€ 20.000,-**.

**Totale jaarlijkse waardecreatie:** **€ 565.000,-**.
**Terugverdientijd:** De investering is binnen **ca. 4 maanden** na volledige adoptie terugverdiend.

---

## 5. RISICO-ANALYSE
* **Single Point of Failure:** De Master-Node is kritiek. *Mitigatie:* Redundante voedingen, RAID-opslag en dagelijkse off-site backups via Rclone (onderdeel van InfraForge).
* **Complexiteit:** De overstap naar Stateless/Nix-architectuur vraagt om een cultuuromslag. *Mitigatie:* De begrote € 30.000,- voor training borgt de noodzakelijke kennisoverdracht.

---

## 6. CONCLUSIE
Deze business case toont aan dat de investering van € 100.000,- niet slechts een aankoop van hardware is, maar de fundamenten legt voor een **onderhoudsvrije, veilige en hyper-efficiënte software-organisatie**. Door de vloot stateless te maken en AI on-premise te halen, creëren we een uniek competitief voordeel.

**Geautoriseerd door:** ____________________  **Datum:** __________
