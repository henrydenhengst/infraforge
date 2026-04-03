# INVESTERINGSVOORSTEL: ARCHITECTUUR VOOR EEN AUTONOME SOFTWARE FACTORY
**Betreft:** Implementatie van Stateless Desktop Provisioning (PLD), InfraForge IaC en On-Premise AI-Inference.

---

## 1. STRATEGISCHE RATIONALE
De huidige IT-operatie kampt met 'technische schuld' op de werkplek. Individuele configuraties van developer-laptops leiden tot inconsistente build-omgevingen ("it works on my machine") en een hoge administratieve druk. Tegelijkertijd dwingt de opkomst van AI tot een keuze: data weggeven aan derden (SaaS) of investeren in eigen soevereiniteit.

Dit voorstel elimineert de beheerslast door de werkplek te reduceren tot een 'commodity' en de intelligentie te centraliseren op een on-premise Master-Node.

---

## 2. DE TECHNISCHE FUNDERING: INFRAFORGE & PLD

### 2.1 Stateless Provisioning (Provisioning Linux Desktops)
In plaats van traditionele installaties passen wij het 'Stateless Fat Client' model toe. Dit is de kern van de Henry den Hengst-methodiek:
* **PXE-Boot & Handshake:** Desktops starten via het netwerk. Er is geen lokaal besturingssysteem dat kan verouderen of corrupt kan raken.
* **De Gelaagde Opbouw (L0 - Functie C):**
    * **L0 (Base):** Een minimale, geharde kernel (Debian/NixOS) wordt ingeladen.
    * **L1 (Hygiëne):** De 'PLD-reset' wist bij elke boot alle lokale configuratie-afwijkingen. Gebruikersrechten en security-policies worden vers afgedwongen.
    * **L2 (Hardware):** De Master-Node detecteert de specifieke GPU (NVIDIA/AMD) en randapparatuur van de client en injecteert de exact benodigde drivers on-the-fly.
    * **Functie C (Application):** De volledige toolchain (IDE's, Docker, compilers) wordt gepusht op basis van de projectgroep in de Ansible-inventory.

### 2.2 InfraForge Infrastructure-as-Code
De Master-Node beheert de vloot middels de InfraForge-repository, een industrie-waardige IaC-stack:
* **70 Ansible Roles:** Gestandaardiseerde bouwstenen voor o.a. CIS-benchmarking, monitoring (Prometheus/Loki) en netwerk-security.
* **310 Applicatiedefinities:** Vooraf geconfigureerde containers die direct inzetbaar zijn, waardoor de 'time-to-hello-world' voor nieuwe projecten wordt verkort van uren naar seconden.
* **Idempotentie:** De garantie dat de infrastructuur altijd terugkeert naar de gedefinieerde 'Golden State', ongeacht handmatige wijzigingen door gebruikers.

---

## 3. ON-PREMISE AI-HOSTING: DE ECONOMIE VAN SOEVEREINITEIT
Het hosten van een Large Language Model (DeepSeek-Coder-V2) op de Master-Node (4x RTX 6000 Ada) is een kritische succesfactor voor deze business case.

### 3.1 Intellectueel Eigendom & Compliance
Software-ontwikkeling is de kernwaarde van de organisatie. Het verzenden van code-repositories naar OpenAI of Anthropic is een onacceptabel risico op IP-verlies en schending van de AVG. 
* **Air-Gapped mogelijkheid:** De AI-node kan volledig afgesloten van het internet opereren, terwijl de programmeurs wel beschikken over state-of-the-art assistentie.
* **Geen Derden-risico:** Geen afhankelijkheid van de API-uptime, datalekken bij providers of plotselinge beleidswijzigingen van Big Tech.

### 3.2 Diepe Integratie met de Eigen Stack
In tegenstelling tot algemene AI-modellen, kan het lokale model worden geïntegreerd met de InfraForge-documentatie en de PLD-workflows. 
* De AI kent de 70 specifieke Ansible-rollen binnen de organisatie.
* De AI genereert code die direct voldoet aan de interne standaarden voor logging, security en deployment.

---

## 4. FINANCIEEL KADER EN ROI

### 4.1 Investeringsbegroting (Totaal € 100.000,-)
| Post | Omschrijving | Investering |
| :--- | :--- | :--- |
| **Hardware** | Master-Node (4x RTX 6000 Ada 48GB, Threadripper 32-core, 512GB RAM, 10GbE) | € 60.000 |
| **Engineering** | Implementatie PXE-stack, GitOps-pipelines en Ansible-integratie | € 10.000 |
| **Training** | Maatwerk scholing voor 25 devs (Stateless workflow & AI-pairing) | € 30.000 |

### 4.2 Operationele Besparingen (Per Jaar)
* **Reductie Support-tickets (PLD):** De 'Self-Healing' natuur van de desktops reduceert werkplekondersteuning met 80%. Besparing: **€ 45.000,-**.
* **Productiviteitswinst (AI + IaC):** Een conservatieve winst van 25% op de totale output van 25 developers (loonsom € 2M). Waardecreatie: **€ 500.000,-**.
* **Infrastructuur-consolidatie:** Vervanging van diverse losse servers en dure SaaS-licenties voor AI. Besparing: **€ 20.000,-**.

**Totale jaarlijkse waarde:** **€ 565.000,-**. 
**Terugverdientijd:** De investering is binnen **69 werkdagen** (ca. 3 maanden) na volledige implementatie terugverdiend.

---

## 5. RISICO-ANALYSE
* **Complexiteit:** De initiële setup vereist diepe Linux-kennis. *Mitigatie:* Gebruik van het bewezen InfraForge-framework en een gericht trainingstraject.
* **Hardwareveroudering:** De gekozen NVIDIA Ada-architectuur is toekomstbestendig voor minimaal 3-5 jaar. De modulaire opbouw van de software maakt hardware-swaps in de toekomst eenvoudig.
* **Continuïteit:** De Master-Node is het 'Single Point of Failure'. *Mitigatie:* Redundante hardware-componenten en dagelijkse off-site backups van de Git-repositories via Rclone.

---

## 6. CONCLUSIE EN ADVIES
De transitie naar een stateless omgeving ondersteund door on-premise AI is de enige manier om als moderne software-organisatie schaalbaar en veilig te blijven. De investering van € 100.000,- is niet louter een kostenpost, maar de financiering van een autonoom ecosysteem dat zichzelf op korte termijn meervoudig terugbetaalt in snelheid, veiligheid en kwaliteit.

**Advies:** Directe goedkeuring voor de aanschaf van de hardware-node en de start van het implementatietraject.

---
**Datum:** 3 april 2026
**Documentstatus:** voorstel

