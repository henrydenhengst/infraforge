# BUSINESS CASE: IMPLEMENTATIE STATELESS INFRASTRUCTUUR, ZERO-TOUCH PROVISIONING EN ON-PREMISE AI-CAPACITEIT

## 1. STRATEGISCHE CONTEXT EN PROBLEEMSTELLING
De huidige software-ontwikkelcyclus binnen professionele organisaties wordt gehinderd door drie kernproblemen:
1. **Configuration Drift:** Individueel beheerde werkstations vertonen na verloop van tijd afwijkingen, wat leidt tot instabiliteit en beveiligingslekken.
2. **Data-Exfiltratie Risico's:** Het gebruik van publieke AI-diensten (SaaS) resulteert in het onbedoeld lekken van intellectueel eigendom (IP) naar externe cloud-providers.
3. **Beheerslast:** Het handmatig onboarden, updaten en repareren van developer-omgevingen legt een onevenredig groot beslag op de IT-capaciteit.

Dit voorstel voorziet in een integrale oplossing door de implementatie van een 'Master-Node' architectuur voor 25 programmeurs, gebaseerd op de InfraForge-methodiek en on-premise AI-inference.

---

## 2. TECHNISCHE ARCHITECTUUR: DE MASTER-NODE
De kern van de infrastructuur is een dedicated rekeneenheid (4x NVIDIA RTX 6000 Ada, Threadripper Pro, 512GB RAM) die fungeert als de 'Control Plane'.

### 2.1 Stateless Provisioning (PLD - Project Log Document)
De vloot van 25 Fat Clients wordt beheerd als 'stateless targets'. Dit betekent dat hardware-units geen permanente lokale configuratie bevatten.
* **L0 - Netboot (PXE):** Clients laden hun kernel en basis-OS (Debian/NixOS) direct van de Master-Node.
* **L1 - Hygiëne & Reset:** Bij elke boot-cyclus vindt de 'PLD-reset' plaats. Tijdelijke data wordt gewist en de machine wordt gesynchroniseerd met de 'Golden Image'.
* **L2 - Dynamische Hardware-injectie:** De Master-Node detecteert on-the-fly de aanwezige hardware (GPU/CPU) en injecteert de correcte firmware en drivers.
* **Functie C - Rolgebaseerde Applicatie-uitrol:** Software-stacks (Docker, K8s-tooling, compilers) worden modulair geladen op basis van de toegekende functiegroep.

### 2.2 InfraForge Engine
De backend-automatisering is vastgelegd in de InfraForge-repository:
* **70 Ansible Roles:** Dekken de volledige operationele behoefte (Hardening, Monitoring, Backup).
* **310 Applicatiedefinities:** Gestandaardiseerde containers voor directe inzetbaarheid.
* **Multi-Distro Support:** Uniforme configuratie over Debian, RedHat, SUSE, Arch en Alpine.

---

## 3. ON-PREMISE AI-HOSTING: STRATEGISCHE NOODZAAK
Een essentieel onderdeel van deze business case is het lokaal hosten van Large Language Models (zoals DeepSeek-Coder-V2). Dit is geen luxe-voorziening, maar een infrastructurele vereiste voor moderne software-engineering.

### 3.1 Data-Soevereiniteit en Intellectueel Eigendom
Bij het gebruik van publieke AI-modellen worden code-snippets, API-keys en architectuurkeuzes verwerkt op servers van derden. On-premise hosting garandeert dat:
* Geen enkele regel broncode de interne infrastructuur verlaat.
* De organisatie voldoet aan strikte compliance-eisen (AVG/GDPR, ISO 27001).
* Er geen afhankelijkheid is van de uptime of prijsstelling van externe API-providers.

### 3.2 Performance en Latency-reductie
Publieke API's kennen variabele latentie en 'rate limits'. Door 192GB VRAM op de Master-Node beschikbaar te stellen, krijgen 25 programmeurs:
* **Constante Token-output:** Snelle code-aanvulling zonder vertraging door netwerkcongestie.
* **Grote Context Windows:** Mogelijkheid om volledige lokale repositories (via RAG - Retrieval Augmented Generation) in het geheugen te laden voor complexe refactoring-taken.

### 3.3 Fine-Tuning op de Interne Stack
Een on-premise systeem kan worden gevoed met de specifieke code-standaarden van de organisatie, inclusief de 70 Ansible-rollen van InfraForge. Hierdoor genereert de AI code die direct compatibel is met de eigen infrastructuur, wat de integratiefase drastisch verkort.

---

## 4. FINANCIËLE ANALYSE (TCO & ROI)
### 4.1 Investeringskosten (Jaar 1)
| Post | Omschrijving | Bedrag |
| :--- | :--- | :--- |
| **Hardware (CAPEX)** | Master-Node (Compute + GPU + Storage) | € 60.000 |
| **Implementatie (OPEX)** | Setup PXE-vloot, GitOps pipeline en AI-model deployment | € 10.000 |
| **Transitie & Training** | Opleiding team in PLD-workflow en AI-ondersteunde ontwikkeling | € 30.000 |
| **TOTAAL** | | **€ 100.000** |

### 4.2 Besparingen en Waardecreatie (Jaarbasis)
1. **Reductie Beheerslast:** Het vervallen van handmatig werkplekbeheer bespaart circa 1.000 manuren per jaar (€ 75.000,-).
2. **Efficiëntiewinst Development:** De combinatie van stateless provisioning (geen downtime door defecte OS-installaties) en lokale AI-ondersteuning verhoogt de output met minimaal 25%. Op een loonsom van € 2.000.000,- (25 FTE) is dit een waarde-stijging van **€ 500.000,-**.
3. **Eliminatie SaaS-kosten:** Besparing op AI-licenties en cloud-infrastructuur (ca. € 15.000,-).

### 4.3 Terugverdientijd
De investering wordt op basis van bovenstaande parameters binnen **4 tot 6 maanden** volledig terugverdiend.

---

## 5. RISICO-ANALYSE
* **Hardware Failure:** De Master-Node wordt uitgevoerd met redundante voedingen en RAID-storage. De stateless natuur van de clients maakt hardware-vervanging van werkstations triviaal.
* **Adoptie:** De training van € 30.000,- is cruciaal om de overstap van traditionele naar stateless workflows te waarborgen.
* **Technologische Veroudering:** Door de modulaire opbouw van InfraForge kunnen onderdelen van de stack (bijv. een nieuw AI-model of een nieuwe Linux-distributie) onafhankelijk van elkaar worden geüpgraded.

---

## 6. CONCLUSIE
De implementatie van een on-premise Master-Node met InfraForge en PLD-provisioning biedt een ongekende graad van operationele controle en veiligheid. Het stelt de organisatie in staat om de voordelen van AI volledig te benutten zonder concessies te doen aan privacy, terwijl de beheerskosten van de IT-vloot structureel worden verlaagd.

**Geautoriseerd door:** ____________________  **Datum:** __________
