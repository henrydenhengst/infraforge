# Linux Café Haarlem Server Deployment

Deze repository bevat de Ansible-configuratie voor de website en infrastructuur van het Linux Café Haarlem op Void Linux.

## Systeemoverzicht
- **Webserver:** Caddy (automatische SSL via DuckDNS/Let's Encrypt)
- **CMS:** Grav (Flat-file, PHP 8.3)
- **OS:** Void Linux met Runit service management
- **Security:** UFW, SSH-hardening, Fail2ban

## Gebruik
1. Zorg voor een werkende Void Linux server met SSH-toegang.
2. Kopieer `secret.example.yml` naar `secret.yml` en vul de tokens in.
3. Start de uitrol:
   ```bash
   ansible-playbook -i inventory.ini site.yml -K
   ```
Hier is je volledige Post-Ansible Checklist:

## 1. De Grav Admin Gebruiker Aanmaken
Ansible installeert Grav, maar maakt om veiligheidsredenen geen beheerder aan.
Open je browser en ga naar: `https://linuxcafehaarlem.duckdns.org/admin`
Je ziet nu een scherm om de User Account aan te maken.
Vul je gebruikersnaam, e-mailadres en een sterk wachtwoord in.
Klik op Create User. Je bent nu ingelogd in het dashboard.

## 2. Thema en Plugins Installeren (CLI-methode)
Hoewel de basis van Grav draait, moeten het Typhoon-thema en de benodigde bouwstenen nog geactiveerd worden. Dit doe je het snelst via SSH op de server:

Log in op je server: `ssh root@linuxcafehaarlem.duckdns.org`

Ga naar de webroot: `cd /var/www/grav`

Voer de GPM (Grav Package Manager) commando's uit als de webserver-gebruiker:

```bash
# Installeren van Typhoon thema en afhankelijkheden
sudo -u _caddy bin/gpm install typhoon -y

# Installeren van de noodzakelijke plugins voor formulieren en e-mail
sudo -u _caddy bin/gpm install form email login admin -y
```

## 3. Het Typhoon Thema Activeren
Ga in de Grav Admin naar Themes.
Zoek naar Typhoon en klik op Activate.
(Optioneel): Typhoon werkt vaak met een "Skeleton". Als je een compleet voorbeeld wilt van hoe de site eruit kan zien, kun je de demo-content van de Typhoon-pagina downloaden en in je user/pages map plaatsen.

## 4. E-mail Configureren (Cruciaal voor je mailscript)
Zonder SMTP-instellingen komen je e-mails waarschijnlijk in de spam.
In de Grav Admin, ga naar Plugins > Email.
Zet de Engine op smtp.
Vul de gegevens in die je in `secret.yml` hebt gezet:
SMTP Server: (bijv. `smtp.transip.nl`)
Port: 587
Encryption: TLS
User / Password: Je e-mailgegevens.
Klik bovenaan op Save.
Test de verbinding met de knop Send Test Email.

## 5. DuckDNS & SSL Controle
Controleer of je certificaat en IP-update goed werken:
SSL: Kijk of er een slotje in de adresbalk staat. Caddy regelt dit zelf, maar het kan 1-2 minuten duren na de eerste start.
Logs: Controleer of de DuckDNS-update script logs produceert:
`cat /var/log/duckdns.log`
Je wilt hier "Update succesvol" zien staan.

## 6. Mattermost Verbinding Testen
Je hebt een reverse proxy ingesteld voor de chat.
Ga naar `https://linuxcafehaarlem.duckdns.org/chat`.
Als Mattermost al op poort 8065 draait, moet je nu het inlogscherm van de chat zien.
Krijg je een "502 Bad Gateway"? Dan staat de Mattermost-service waarschijnlijk nog uit of luistert deze op een andere poort.

## 7. De One-Page Structuur opzetten
Nu de techniek werkt, moet je de content structureren voor een "One-Pager":
Ga naar Pages.
Maak een map aan genaamd 01.home.
Zet het type op Modular.
Maak daaronder "Modules" aan (bijv. _hero, _about, _partners, _contact).
In de instellingen van de pagina (Advanced tab) zorg je dat de slug op / staat.

## 8. Back-up Plan (Optioneel maar aangeraden)
Omdat Grav geen database heeft, hoef je alleen de `user/` map te backuppen.
Maak af en toe een kopie van `/var/www/grav/user` naar je lokale machine.
Alles (je teksten, instellingen en afbeeldingen) staat in die ene map.
Klaar! Je server is nu niet alleen technisch geconfigureerd, maar ook functioneel ingericht voor het Linux Café.

