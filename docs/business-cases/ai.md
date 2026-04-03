# BUSINESS CASE: Implementatie AI-Native Infrastructure & Zero-Touch Desktop Provisioning

## 1. EXECUTIEVE SAMENVATTING
Dit voorstel beschrijft de transitie naar een volledig geautonomeerde ontwikkelomgeving voor 25 programmeurs. Door de synergie van on-premise AI (DeepSeek-Coder-V2) en GitOps-gedreven infrastructuur (InfraForge & PLD), realiseren wij een significante stijging in software-output, 100% data-soevereiniteit en een drastische reductie in beheerslast.

---

## 2. STRATEGISCHE PILLERS
* **Private Intelligence:** Inzet van DeepSeek-Coder-V2 (236B) op eigen hardware voor veilige code-generatie.
* **InfraForge Ecosystem:** Gebruik van ~70 geavanceerde Ansible-rollen en ~310 applicatiedefinities voor gestandaardiseerde, OS-agnostische omgevingen.
* **Zero-Touch Provisioning (PLD):** Stateless Linux Fat Clients die zichzelf bij elke boot herstellen en configureren via PXE/GitOps, waardoor "local drift" geëlimineerd wordt.

---

## 3. TECHNISCHE ARCHITECTUUR (HET POWERHOUSE)
De centrale node fungeert als "Intelligence Hub" en "Provisioning Master".

| Component | Specificatie | Rol in het ecosysteem |
| :--- | :--- | :--- |
| **GPU Cluster** | 4x NVIDIA RTX 6000 Ada (192GB VRAM) | Inference engine voor DeepSeek-V2 Full |
| **Compute** | AMD Threadripper Pro 7975WX (32-core) | Ansible execution engine & Docker/K8s host |
| **Memory** | 512GB DDR5 ECC | Caching van OS-images & Large Context Windows |
| **Storage** | NVMe Gen5 RAID | Lokale Binary Cache voor InfraForge & PLD-logs |

---

## 4. INVESTERINGSBEGROTING (JAAR 1)
| Categorie | Post | Bedrag |
| :--- | :--- | :--- |
| **CAPEX** | AI-Server & Netwerk-infra | € 60.000 |
| **OPEX** | Beheer, Energie & Licenties (vrijgesteld via FOSS) | € 10.000 |
| **Inablement** | Maatwerk Training (InfraForge, PLD & Prompting) | € 30.000 |
| **TOTAAL** | | **€ 100.000** |

---

## 5. OPERATIONELE EFFICIËNTIE (ROI)
Basis: Team van 25 developers (Loonsom € 2.000.000,- / jaar).

### A. Development Winst (DeepSeek + InfraForge)
* **Versnelling:** 30% door AI-pairing en het hergebruik van de 310 voorgedefinieerde applicatiestacks.
* **Waarde:** € 600.000,- per jaar.

### B. Ops & Provisioning Winst (PLD)
* **Zero Maintenance:** Geen handmatige updates of reparaties van desktops meer. Besparing: 4 uur per dev/maand.
* **Waarde:** 25 x 4u x € 75,- = € 90.000,- per jaar.

### C. Totale Besparing
* **Netto Jaarlijks Voordeel:** **€ 670.000,-** (na aftrek van jaarlijkse afschrijving en beheer).
* **Payback Period:** De volledige investering is binnen **4 maanden** terugverdiend.

---

## 6. RISICO-BEHEERSING
* **Continuïteit:** De 'Headless by Default' filosofie minimaliseert downtime en aanvals-oppervlakken.
* **Vendor Lock-in:** 0%. Alle tooling is Open Source (NixOS/Debian, Ansible, DeepSeek).
* **Security:** "Security by Design" middels Vault-integratie en CIS-benchmarks binnen de InfraForge-rollen.

---

## 7. CONCLUSIE
De combinatie van brute hardware-kracht en de geavanceerde automatisering van de Henry den Hengst-repositories (InfraForge/PLD) transformeert de IT-afdeling van een kostenpost naar een strategische accelerator. Het advies is om onmiddellijk over te gaan tot de inrichting van de centrale Powerhouse-node.

**Autorisatie:** ____________________  **Datum:** __________
