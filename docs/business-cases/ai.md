# BUSINESS CASE: Implementatie On-Premise AI-Infrastructuur (DeepSeek-Coder-V2)

## 1. SAMENVATTING
Dit voorstel betreft de investering in een eigen, hoogwaardige AI-rekennode voor de ondersteuning van 25 software developers. Door gebruik te maken van het FOSS (Free and Open Source) model DeepSeek-Coder-V2 (236B), garanderen wij 100% data-privacy en verhogen wij de software-output met naar schatting 30%.

---

## 2. DOELSTELLINGEN
* **Data Souvereiniteit:** Volledige eliminatie van het risico op lekken van intellectueel eigendom (IP) naar externe AI-clouds.
* **Productiviteitswinst:** Versnelling van development-cycli, met specifieke focus op Ansible-automatisering en unit-testing.
* **Kostenbeheersing:** Vaste infrastructuurkosten in plaats van variabele, stijgende licentiekosten per gebruiker.

---

## 3. TECHNISCHE SPECIFICATIES (OPEX/CAPEX)
De gekozen configuratie is een Linux-gebaseerd workstation/server-systeem geoptimaliseerd voor Large Language Models (LLMs).

| Component | Specificatie |
| :--- | :--- |
| **GPU** | 4x NVIDIA RTX 6000 Ada (192GB VRAM totaal) |
| **CPU** | AMD Threadripper Pro 7975WX (32-core) |
| **RAM** | 512GB DDR5 ECC |
| **Software Stack** | Ubuntu Server, vLLM, Docker, Open WebUI |

---

## 4. INVESTERINGSBEGROTING (INDICATIEF)
De totale investering over de eerste 12 maanden bedraagt circa € 80.000,-.

| Post | Kosten | Toelichting |
| :--- | :--- | :--- |
| **Hardware (CAPEX)** | € 55.000 | Eenmalige aanschaf hardware |
| **Training (25 devs)** | € 30.000 | Maatwerk AI-pairing & Prompt Engineering |
| **Beheer & Energie** | € 15.000 | Support, stroom en koeling (jaarbasis) |
| **TOTAAL JAAR 1** | **€ 100.000** | **Afschrijving over 5 jaar: € 20k/jaar** |

---

## 5. RETURN ON INVESTMENT (ROI)
De business case is gebaseerd op een team van 25 developers met een gemiddelde loonsom van € 80.000,- per jaar.

* **Totale loonsom team:** € 2.000.000 / jaar.
* **Gecalculeerde efficiëntiewinst (30%):** De output van het team stijgt naar een waarde van € 2.600.000.
* **Bruto jaarlijkse besparing:** € 600.000.
* **Netto resultaat (na kosten):** **€ 580.000 per jaar.**
* **Terugverdientijd:** < 3 maanden na volledige adoptie.

---

## 6. RISICO-ANALYSE
* **Technologische veroudering:** AI-hardware ontwikkelt snel. Afschrijving op 5 jaar is fiscaal correct, maar economische vervanging na 3 jaar wordt voorzien.
* **Adoptie:** Zonder de begrote training blijft de winst steken op <10%. Training is kritiek pad.
* **Beheer:** Vereist Linux/Ansible expertise (reeds intern aanwezig).

---

## 7. CONCLUSIE EN ADVIES
De investering in een eigen DeepSeek-node is vanuit strategisch (privacy) en financieel (ROI) oogpunt zeer rendabel. Geadviseerd wordt om over te gaan tot aanschaf en het trainingstraject parallel aan de levering te starten.

**Goedgekeurd door:** ____________________  **Datum:** __________
