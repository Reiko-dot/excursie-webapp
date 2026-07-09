-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Gegenereerd op: 09 jul 2026 om 21:52
-- Serverversie: 10.4.32-MariaDB
-- PHP-versie: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `excursie_database`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `exc_emergency_contacts`
--

CREATE TABLE `exc_emergency_contacts` (
  `id` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `number` varchar(60) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Gegevens worden geëxporteerd voor tabel `exc_emergency_contacts`
--

INSERT INTO `exc_emergency_contacts` (`id`, `name`, `number`, `sort_order`) VALUES
(1, 'Algemeen alarmnummer (ambulance/brandweer)', '112', 1),
(2, 'Politie', '110', 2),
(3, 'Nederlandse ambassade Berlijn', '[in te vullen]', 3),
(4, 'Contactpersoon docent(en) t.p.', '[in te vullen]', 4),
(5, 'Adres hotel/verblijf', '[in te vullen]', 5);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `exc_info_lists`
--

CREATE TABLE `exc_info_lists` (
  `id` int(11) NOT NULL,
  `section` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Gegevens worden geëxporteerd voor tabel `exc_info_lists`
--

INSERT INTO `exc_info_lists` (`id`, `section`, `content`, `sort_order`) VALUES
(1, 'heenreis', 'We reizen met de touringcar naar Berlijn, reken op zo\'n 9 tot 10 uur onderweg inclusief pauzes.', 1),
(2, 'heenreis', 'Neem iets te doen mee voor onderweg (koptelefoon, opgeladen telefoon/laptop, boek).', 2),
(3, 'ov_tickets', 'Eén ticket geldt voor U-Bahn, S-Bahn, bus én tram (zone AB dekt bijna alles binnen de stad).', 1),
(4, 'ov_tickets', 'Stempel je kaartje bij de gele automaatjes op het perron — controle is onopvallend maar de boete is hoog.', 2),
(5, 'ov_tickets', 'Een dagkaart (Tageskarte) is vaak voordeliger dan losse ritjes vanaf 3+ ritten per dag.', 3),
(6, 'ov_tickets', 'Download de app \"BVG Fahrinfo\" of \"Öffi\" voor live reisplanning offline.', 4),
(7, 'goed_om_te_weten', 'Duitsland gebruikt hetzelfde stopcontact als Nederland (type F) — geen adapter nodig.', 1),
(8, 'goed_om_te_weten', 'Contactloos betalen wordt steeds normaler, maar veel kleine eetkraampjes en imbisses zijn cash-only. Neem wat contant geld mee.', 2),
(9, 'goed_om_te_weten', 'Fooi geven (5-10%) wordt gewaardeerd in restaurants, maar is niet verplicht zoals in de VS.', 3),
(10, 'goed_om_te_weten', 'Zorg voor een geldige Europese zorgverzekeringskaart (EHIC) of reisverzekering.', 4),
(11, 'goed_om_te_weten', 'WiFi is breed beschikbaar in cafés en het OV, maar zet voor de zekerheid ook wat mobiele data klaar.', 5);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `exc_items`
--

CREATE TABLE `exc_items` (
  `id` int(11) NOT NULL,
  `category` enum('sight','activity') NOT NULL,
  `title` varchar(120) NOT NULL,
  `tag` varchar(40) NOT NULL,
  `description` text NOT NULL,
  `tip` text NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `icon_color` varchar(10) NOT NULL DEFAULT '#D44D5C',
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Gegevens worden geëxporteerd voor tabel `exc_items`
--

INSERT INTO `exc_items` (`id`, `category`, `title`, `tag`, `description`, `tip`, `image_url`, `icon_color`, `sort_order`) VALUES
(1, 'sight', 'Brandenburger Tor', 'Icoon', 'Het meest gefotografeerde symbool van Berlijn en van de Duitse eenwording. \'s Avonds prachtig verlicht.', 'Kom rond zonsondergang voor de beste foto\'s, veel minder druk dan overdag.', 'https://images.unsplash.com/photo-1560969184-10fe8719e047?w=600', '#D44D5C', 1),
(2, 'sight', 'Reichstagsgebäude', 'Architectuur', 'De glazen koepel van het Duitse parlement geeft een 360°-uitzicht over de stad en laat zien hoe transparantie in architectuur wordt vertaald.', 'Reserveer de koepel gratis van tevoren online — plekken zijn snel vol.', 'https://lh3.googleusercontent.com/gps-cs-s/AHRPTWnY7UD2ij0Yl3_7Bov4wFgzyX33S3XZhOK-Czl93d4Z2d3sHDV_ZRbpky2Ay64M3DuQ5jbB_AH60OOZtsYr2ZGFlj09RnhMRA74JkZk2hTbmgR4v9UORWi-XQ5pFAU0w88ZVyKO=s1360-w1360-h1020-rw', '#D44D5C', 2),
(3, 'sight', 'East Side Gallery', 'Street art', '1,3 km origineel stuk Berlijnse Muur, volgeschilderd door kunstenaars uit de hele wereld. Een verplicht adres voor iedereen die met visuele cultuur bezig is.', 'Loop \'m in de ochtend voor rustige foto\'s zonder mensen ervoor.', 'https://lh3.googleusercontent.com/gps-cs-s/AHRPTWkhdm9LyAHeaVm61KrdjuHn-Y9QzwC9L0b4fgM8ayQcFY8Bf58Hc_ulV6RI8nDC0Tp_QlmZugKlk9jJ-kAffao153KLrUBUsCnCrlCDziuIbZgKOldF4UC5bUQXR6B-HMT81lh4a0-9xnE=s1360-w1360-h1020-rw', '#D44D5C', 3),
(4, 'sight', 'Museumsinsel', 'Museum', 'UNESCO-eiland met vijf topmusea, waaronder het Pergamonmuseum. Antieke architectuur op ware grootte, letterlijk binnen.', 'Neem de Berlin WelcomeCard museum-optie als je meerdere musea wilt zien.', 'https://www.varta-guide.de/wp-content/uploads/2016/10/Bode-Museum-Berlin.jpg', '#D44D5C', 4),
(5, 'sight', 'Fernsehturm Alexanderplatz', 'Uitzicht', '368 meter hoge tv-toren met draaiend restaurant. Op heldere dagen zie je tot 40 km ver — goed startpunt om de stad te leren lezen.', 'Boek een tijdslot online, anders sta je makkelijk 1-2 uur in de rij.', 'https://www.berlin.de/binaries/asset/image_assets/6274092/source/1750930793/1000x500/', '#D44D5C', 5),
(6, 'sight', 'Checkpoint Charlie', 'Geschiedenis', 'Beroemdste grensovergang tussen Oost- en West-Berlijn tijdens de Koude Oorlog. Nu een openluchtmuseum met foto\'s en context.', 'Combineer met het Mauermuseum ernaast voor de volledige geschiedenis.', 'https://www.berlin.de/binaries/asset/image_assets/9267636/ratio_4_3/1773135227/800x600/', '#D44D5C', 6),
(7, 'sight', 'Gedenkstätte Berliner Mauer', 'Geschiedenis', 'Op de Bernauer Straße staat nog een origineel stuk grensstrook, inclusief wachttoren — indrukwekkender en stiller dan de East Side Gallery.', 'Gratis toegang, ga in combinatie met een korte wandeling langs de Mauerweg.', 'https://www.berlin.de/binaries/asset/image_assets/9644956/source/1746789298/1000x500/', '#D44D5C', 7),
(8, 'activity', 'Mauerpark op zondag', 'Weekend', 'Vlooienmarkt overdag, gratis openlucht-karaoke in het amfitheater aan het einde van de middag. Dé plek om lokale student vibes op te snuiven.', 'Alleen op zondag — check dus de datum van de excursie hierop.', 'https://berlijn-blog.nl/wp-content/uploads/2013/03/20150628-DSCF0110-BerlijnBlog-Berlijn-Mauerpark.jpg', '#E3B5A4', 1),
(9, 'activity', 'Markthalle Neun — Street Food Thursday', 'Eten', 'Donderdagavond verandert deze markthal in Kreuzberg in een internationale street food markt. Betaalbaar en heel geschikt voor groepen.', 'Ga vroeg, vanaf 17:00 wordt het snel druk.', 'https://hellojetlag.com/wp-content/uploads/2018/01/Markthalle-Berlin-Street-Food-Thursday-16.jpg', '#E3B5A4', 2),
(10, 'activity', 'Fietstour door de stad', 'Actief', 'Berlijn is extreem fietsvriendelijk. Een gegidste of eigen fietstour langs Tiergarten, Muurresten en Alexanderplatz laat je in een paar uur veel zien.', 'Studentenkorting bij de meeste verhuurbedrijven, vraag er altijd naar.', 'https://berlinonbike.de/wp-content/uploads/sites/4383/2024/01/BerlinonBike_Highlights-24.jpg?w=700&h=700&zoom=2', '#E3B5A4', 3),
(11, 'activity', 'Currywurst proeven', 'Eten', 'Curry 36 en Konnopke\'s Imbiss zijn de bekendste adressen voor het gerecht dat in Berlijn is uitgevonden. Snel, goedkoop, typisch Berlijns.', 'Konnopke\'s zit onder de U-Bahnbrug bij Eberswalder Straße — leuke sfeer.', 'https://sterkindekeuken.nl/wp-content/uploads/2026/02/curryworst.jpg', '#E3B5A4', 4),
(12, 'activity', 'Dagtrip naar Potsdam', 'Uitje', 'Half uur met de trein voor Slot Sanssouci en prachtige paleistuinen — een rustig contrast met de drukte van Berlijn.', 'Het reguliere OV-ticket dekt de rit naar Potsdam ook, geen apart kaartje nodig.', 'https://media.tacdn.com/media/attractions-splice-spp-674x446/06/d0/c0/71.jpg', '#E3B5A4', 5),
(13, 'activity', 'Shoppen: Alexa & KaDeWe', 'Shoppen', 'Alexa bij Alexanderplatz voor betaalbare ketens, KaDeWe voor het grootste warenhuis van het vasteland van Europa — leuk om te zien, ook als je niet koopt.', 'De foodhal boven in KaDeWe is gratis te bezoeken en het uitzicht is de moeite waard.', 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAENCtXZnRVqhAg1wYV3T-d1r_C8TNEEI3zS6psUlr9yCd561ZH0UQvXQ3dHVrAn-zCU5WQ2SOmCRNQQgpMM3uskfypAt_QE4lrvK9OLrhXTtDZLSh1zRgJBAq4ozZiXdsdG9izuHEe8M3lf=s1360-w1360-h1020-rw', '#E3B5A4', 6),
(14, 'activity', 'Avondwandeling Friedrichshain-Kreuzberg', 'Uitgaan', 'De wijk waar Berlijns nachtleven groot werd: bars, live muziek en straatkunst dicht bij elkaar. Ook overdag leuk om doorheen te lopen.', 'Blijf in groepjes en check vooraf de leeftijdsgrenzen van eventuele clubs.', 'https://voss-photography.com/wp-content/uploads/2021/05/friedrichshain-kreuzberg-berlin-1.jpg', '#E3B5A4', 7);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `exc_quick_facts`
--

CREATE TABLE `exc_quick_facts` (
  `id` int(11) NOT NULL,
  `label` varchar(60) NOT NULL,
  `value` varchar(60) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Gegevens worden geëxporteerd voor tabel `exc_quick_facts`
--

INSERT INTO `exc_quick_facts` (`id`, `label`, `value`, `sort_order`) VALUES
(1, 'Reistijd bus', '~9-10u', 1),
(2, 'Taal', 'Duits', 2),
(3, 'Valuta', 'Euro (€)', 3),
(4, 'Stopcontact', 'Type F', 4);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `exc_shortcuts`
--

CREATE TABLE `exc_shortcuts` (
  `id` int(11) NOT NULL,
  `target_view` varchar(30) NOT NULL,
  `title` varchar(60) NOT NULL,
  `subtitle` varchar(80) NOT NULL,
  `full_width` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Gegevens worden geëxporteerd voor tabel `exc_shortcuts`
--

INSERT INTO `exc_shortcuts` (`id`, `target_view`, `title`, `subtitle`, `full_width`, `sort_order`) VALUES
(1, 'sights', 'Bezienswaardigheden', '7 plekken', 0, 1),
(2, 'activities', 'Activiteiten & tips', '7 ideeën', 0, 2),
(3, 'practical', 'Praktische info', 'Kaart · OV · noodnummers', 1, 3);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `exc_site_content`
--

CREATE TABLE `exc_site_content` (
  `content_key` varchar(64) NOT NULL,
  `content_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Gegevens worden geëxporteerd voor tabel `exc_site_content`
--

INSERT INTO `exc_site_content` (`content_key`, `content_value`) VALUES
('brand_sub', 'Alles voor onderweg'),
('brand_title', 'Duitsland excursie'),
('heading_emergency', 'Noodnummers'),
('heading_heenreis', 'Heenreis'),
('heading_know', 'Goed om te weten'),
('heading_map', 'Kaart'),
('heading_ov', 'Openbaar vervoer in de stad'),
('hero_desc', 'Vijf dagen Bauhaus, Berlijnse Mauer en beats — alles wat je moet weten voor de excursie op één plek.'),
('hero_eyebrow', 'Volgend schooljaar · Excursie'),
('hero_title', 'BERLIN'),
('label_activities', 'Doen & proeven'),
('label_home', 'Bestemming'),
('label_practical', 'Onderweg'),
('label_quicknav', 'Snel naar'),
('label_sights', 'Ontdek de stad'),
('map_embed_url', 'https://www.google.com/maps?q=Berlin,+Germany&output=embed'),
('map_link_label', 'Open Berlijn in Google Maps →'),
('map_link_url', 'https://www.google.com/maps/place/Berlin'),
('nav_activities', 'Activiteiten'),
('nav_home', 'Home'),
('nav_practical', 'Praktisch'),
('nav_sights', 'Bezienswaardig.'),
('note_activities', '[Docenten: vul hier de definitief geplande groepsactiviteiten en tijden in, zodra bekend.]'),
('note_practical', '[Docenten: vul hier het definitieve verzamelpunt, vluchtnummer/heenreis en het exacte programma per dag in.]'),
('stamp_line1', 'BERLIN'),
('stamp_line2', '2027'),
('title_activities', 'Activiteiten & tips'),
('title_home', 'Berlijn'),
('title_practical', 'Praktische info'),
('title_sights', 'Bezienswaardigheden'),
('why_heading', 'Waarom Berlijn'),
('why_text', 'Berlijn is de stad van geschiedenis én street culture: een verdeelde stad die weer één werd, vol street art, techno-clubs, musea en een designscene die naadloos aansluit op wat je op GLU leert. Perfect voor wie zich met UI, branding en visuele cultuur bezighoudt.');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `exc_transit_lines`
--

CREATE TABLE `exc_transit_lines` (
  `id` int(11) NOT NULL,
  `badge_text` varchar(4) NOT NULL,
  `badge_class` varchar(10) NOT NULL,
  `title` varchar(40) NOT NULL,
  `description` text NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Gegevens worden geëxporteerd voor tabel `exc_transit_lines`
--

INSERT INTO `exc_transit_lines` (`id`, `badge_text`, `badge_class`, `title`, `description`, `sort_order`) VALUES
(1, 'U', 'u', 'U-Bahn', 'metro, rijdt door de hele stad, ook \'s nachts in het weekend.', 1),
(2, 'S', 's', 'S-Bahn', 'sneltrein, goed voor langere afstanden en Potsdam.', 2),
(3, 'B', 'bus', 'Bus & tram', 'vult de gaten op waar geen metro/trein komt, met name in het oosten.', 3);

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `exc_emergency_contacts`
--
ALTER TABLE `exc_emergency_contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `exc_info_lists`
--
ALTER TABLE `exc_info_lists`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `exc_items`
--
ALTER TABLE `exc_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `exc_quick_facts`
--
ALTER TABLE `exc_quick_facts`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `exc_shortcuts`
--
ALTER TABLE `exc_shortcuts`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `exc_site_content`
--
ALTER TABLE `exc_site_content`
  ADD PRIMARY KEY (`content_key`);

--
-- Indexen voor tabel `exc_transit_lines`
--
ALTER TABLE `exc_transit_lines`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `exc_emergency_contacts`
--
ALTER TABLE `exc_emergency_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT voor een tabel `exc_info_lists`
--
ALTER TABLE `exc_info_lists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT voor een tabel `exc_items`
--
ALTER TABLE `exc_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT voor een tabel `exc_quick_facts`
--
ALTER TABLE `exc_quick_facts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT voor een tabel `exc_shortcuts`
--
ALTER TABLE `exc_shortcuts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT voor een tabel `exc_transit_lines`
--
ALTER TABLE `exc_transit_lines`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
