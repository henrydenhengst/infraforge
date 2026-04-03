# BUSINESS CASE: Implementatie AI-Native Infrastructure & Stateless Desktop Provisioning

## 1. EXECUTIEVE SAMENVATTING
Dit voorstel betreft de inrichting van een "Self-Healing" ontwikkelomgeving voor 25 programmeurs. Door de combinatie van een on-premise DeepSeek-AI-node en de "Zero-Touch" provisioning methodiek van Henry den Hengst, creëren we een vloot van Linux Fat Clients die 100% consistent, veilig en onderhoudsvrij zijn.

---

## 2. DE TECHNISCHE REVOLUTIE: GELAAGDE ARCHITECTUUR
In tegenstelling tot traditionele werkplekbeheer, maken wij gebruik van een modulaire opbouw (InfraForge/PLD) die direct vanaf de centrale 100K-node wordt gestreamd:

* **L0 - De OS-Laag:** Netwerk-bootstrapping (PXE) van Debian/NixOS. Geen lokale installatie nodig.
* **L1/L2 - Hygiëne & Hardware:** Automatische injectie van NVIDIA/AMD drivers en security-hardening bij elke boot.
* **Functie C - Applicatie-Laag:** Directe uitrol van ~310 applicatiedefinities (Docker/K8s) op basis van de rol van de developer.
* **Self-Healing:** Bij elke herstart wordt de machine teruggebracht naar de "Golden Image". Lokale "rommel" of configuratie-fouten worden automatisch gewist.

---

## 3. INFRAFORGE ALS ENGINE (70+ ANSIBLE ROLES)
De centrale node fungeert als de "Intelligence Hub" voor de gehele vloot:
* **70 Ansible Roles:** Dekken de volledige lifecycle (Security, Backup, Monitoring).
* **GitOps Workflow:** Wijzigingen in de centrale repository (`group_vars/all.yml`) worden onmiddellijk en automatisch doorgevoerd op alle 25 werkstations.
* **Headless by Default:** Maximale rekenkracht van de 100K-hardware gaat naar AI-inference, niet naar server-overhead.

---

## 4. INVESTERINGSBEGROTING (JAAR 1)
| Categorie | Onderdeel | Bedrag |
| :--- | :--- | :--- |
| **Hardware** | 4x RTX 6000 Ada Server (Master Node) | € 60.000 |
| **Implementatie** | Inrichting InfraForge-vloot & GitOps Pipeline | € 10.000 |
| **Training** | Mastery van de PLD-workflow & AI-pairing | € 30.000 |
| **TOTAAL** | (Afschrijving € 20k/jaar) | **€ 100.000** |

---

## 5. OPERATIONELE ROI (25 PROGRAMMEURS)
Basis: Loonsom team € 2.000.000,- / jaar.

* **Eliminatie 'Desktop Drift':** Geen handmatige reparaties of herinstallaties meer. Winst: **€ 90.000,-/jr.**
* **AI-Acceleratie (DeepSeek):** 30% snellere code-oplevering via lokale API-integratie in de "Functie C" laag. Winst: **€ 600.000,-/jr.**
* **Onboarding Snelheid:** Nieuwe developers zijn binnen 10 minuten up-and-running (Zero-Touch).

---

## 6. CONCLUSIE & ADVIES
Door af te stappen van individueel beheerde laptops en te kiezen voor een centraal aangestuurde "InfraForge" vloot, verlagen we de technische schuld naar nagenoeg nul. De 100K investering levert niet alleen AI-kracht, maar een volledig zelf-herstellend ecosysteem dat zichzelf binnen één kwartaal terugverdient.

**Autorisatie:** ____________________  **Datum:** __________
