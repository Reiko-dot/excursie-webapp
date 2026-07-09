# Excursie Webapp — Berlijn 🇩🇪

Dit project is een interactieve, mobielvriendelijke webapplicatie die speciaal is ontworpen voor een groeps- of schoolexcursie naar Berlijn. De app dient als een digitale reisgids waar reizigers alle belangrijke informatie direct bij de hand hebben. 

Omdat de app is gebouwd als een **Progressive Web App (PWA)**, werkt hij supersnel en blijft alle informatie ook beschikbaar als je onderweg in Berlijn even geen internet of bereik hebt.

---

##  Wat is er te zien en te doen?

De applicatie is opgebouwd als een *Single Page Application* met een handig navigatiemenu onderaan het scherm. Er zijn vier hoofdschermen (views) te bekijken:

1. **Home:** De startpagina met een warm welkom, een interactieve Google Maps-kaart van Berlijn, handige snelkoppelingen naar andere schermen en een 'ticker-strip' met snelle feitjes over de stad (zoals munteenheid, alarmnummer en reistijd).
2. **Bezienswaardigheden (Sights):** Een overzicht van de 7 belangrijkste highlights van Berlijn (zoals de Brandenburger Tor en de East Side Gallery), compleet met een mooie foto, een korte beschrijving en een handige, exclusieve reistip.
3. **Activiteiten (Activities):** Een overzicht van 7 leuke groepsactiviteiten (zoals de vlooienmarkt in het Mauerpark of een fietstour), eveneens voorzien van foto's en praktische tips (bijvoorbeeld over studentenkorting).
4. **Praktische info:** Een onmisbaar scherm met realtime-informatie over de heenreis, het openbaar vervoer (inclusief metrolijnen), belangrijke noodnummers en algemene 'goed om te weten'-zaken.

---

##  Gebruikte Technieken

Voor dit project is gekozen voor een combinatie van moderne frontend-technieken en een betrouwbare backend:

* **Frontend (User Interface):**
  * **HTML5:** Voor de semantische en toegankelijke basisstructuur van de app.
  * **CSS3:** Voor een modern, op maat gemaakt design (gebaseerd op een warm Berlijns kleurpalet). Er is gebruikgemaakt van *CSS Variables* voor kleurbeheer en *Flexbox/Grid* voor een perfecte mobiele lay-out.
  * **Vanilla JavaScript (ES6+):** Regelt de navigatie tussen de schermen zonder dat de pagina hoeft te herladen, en bouwt de interface dynamisch op met de gegevens uit de database.
* **Backend & Database:**
  * **PHP (8.x):** Vormt de motor van de API (`api.php`). Deze communiceert veilig met de database via **PDO (PHP Data Objects)**.
  * **MySQL:** De database waarin alle teksten, categorieën, reistips, metrolijnen en afbeelding-URL's netjes zijn opgeslagen.
* **PWA Functionaliteiten (Progressive Web App):**
  * **Service Worker (`sw.js`):** Zorgt voor de offline-werking. Bestanden (de app-shell) en databasegegevens (JSON-data) worden slim gecachet.
  * **Web App Manifest (`manifest.json`):** Zorgt ervoor dat de app als een echte applicatie op het startscherm van een telefoon geïnstalleerd kan worden.

---

##  Hoe heb ik dit gemaakt? (De Logica)

In plaats van alle teksten en afbeeldingen handmatig in de HTML te typen, heb ik gekozen voor een **data-gedreven aanpak**. Dit betekent dat de app volledig flexibel is:

1. **De Database als basis:** Alle content (van de titel van de app tot de specifieke tip van een activiteit) staat in MySQL-tabellen. Als er een foto of tekst verandert, hoeft dit alleen in de database aangepast te worden.
2. **De API als doorgeefluik:** Wanneer de app opstart, doet JavaScript een digitaal verzoek (*fetch*) naar `api.php`. Dit PHP-bestand haalt vliegensvlug alle gegevens op uit de database en zet dit om in één overzichtelijk JSON-pakket.
3. **Dynamische opbouw:** JavaScript vangt dit JSON-pakket op en genereert door middel van loops (`map` en `forEach`) de HTML-kaarten voor de bezienswaardigheden en activiteiten op het scherm.
4. **Offline Cache:** De Service Worker luistert op de achtergrond mee. Heb je eenmaal de app geopend met internet? Dan slaat de Service Worker de gegevens op. Zit je daarna in de metro in Berlijn zonder internet? Dan toont de app de laatst opgeslagen gegevens uit de cache en krijgt de gebruiker een subtiele melding dat hij offline is.

---

##  Hoe start je dit project op?

1. Importeer het `.sql` bestand in je lokale databasebeheerder (bijv. phpMyAdmin via XAMPP).
2. Controleer in `db/config.php` of de database-inloggegevens (host, dbname, user, password) correct zijn ingesteld.
3. Start je lokale server op en open de map in je browser (bijvoorbeeld via `http://localhost/berlijn-excursie/`).
4. Om de PWA-installatie en de Service Worker optimaal te testen, is een beveiligde verbinding (`https://`) of een lokale `localhost` omgeving vereist.