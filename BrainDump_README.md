# FlowNote — Brain Dump & Quick Capture App

## Inhoudstafel

1. [Projectoverzicht](#projectoverzicht)
2. [Probleemstelling](#probleemstelling)
3. [Doel van de app](#doel-van-de-app)
4. [Doelgroep](#doelgroep)
5. [Kernidee](#kernidee)
6. [Belangrijkste functionaliteiten](#belangrijkste-functionaliteiten)
7. [Onboarding flow](#onboarding-flow)
8. [App schermen](#app-schermen)
9. [Gebruikersflow](#gebruikersflow)
10. [Designvisie](#designvisie)
11. [Navigatiestructuur](#navigatiestructuur)
12. [Datamodel](#datamodel)
13. [MVP-scope](#mvp-scope)
14. [Uitbreidingen zonder AI](#uitbreidingen-zonder-ai)
15. [Notificaties](#notificaties)
16. [Privacy en opslag](#privacy-en-opslag)
17. [Technische aanpak](#technische-aanpak)
18. [Mogelijke mappenstructuur](#mogelijke-mappenstructuur)
19. [Roadmap](#roadmap)
20. [Monetisatie](#monetisatie)
21. [Conclusie](#conclusie)

---

## Projectoverzicht

**FlowNote** is een minimalistische productiviteitsapp waarmee gebruikers snel gedachten, taken, ideeën en losse informatie kunnen vastleggen zonder afleiding.

De app is ontworpen rond één centrale gedachte:

> Alles wat in je hoofd zit, moet je binnen enkele seconden kunnen vastleggen.

FlowNote is geen klassieke notitie-app met mappen, documenten en complexe structuren. De app werkt eerder als een digitale mentale inbox. Gebruikers openen de app, typen of spreken een gedachte in en slaan die direct op. Later kunnen ze hun items bekijken, zoeken, afwerken of verwerken via een dagelijkse review.

De app focust op eenvoud, snelheid en dagelijks gebruik.

---

## Probleemstelling

Veel mensen hebben dagelijks last van mentale druk door losse gedachten, kleine taken, ideeën of dingen die ze niet mogen vergeten.

Voorbeelden:

- “Ik moet die klant nog antwoorden.”
- “Ik mag straks niet vergeten melk te kopen.”
- “Ik had net een goed app-idee.”
- “Ik moet morgen dat document afwerken.”
- “Ik wil straks nog iets opzoeken.”

Vaak worden deze zaken niet genoteerd omdat bestaande apps te veel stappen vragen. Een gebruiker moet bijvoorbeeld eerst een app openen, een map kiezen, een categorie selecteren, een titel invullen en daarna pas typen.

Daardoor blijven gedachten in het hoofd zitten of worden ze vergeten.

FlowNote lost dit op door alle drempels weg te nemen.

---

## Doel van de app

Het doel van FlowNote is om gebruikers te helpen hun hoofd leeg te maken en meer focus te krijgen door gedachten direct vast te leggen.

De app wil:

- mentale rust creëren
- vergeten verminderen
- productiviteit verhogen
- dagelijkse reflectie stimuleren
- losse gedachten omzetten naar bruikbare acties

FlowNote moet aanvoelen als een app die je meerdere keren per dag opent, zonder dat het gebruik moeite kost.

---

## Doelgroep

FlowNote richt zich op mensen die veel aan hun hoofd hebben en nood hebben aan een eenvoudige manier om gedachten snel vast te leggen.

### Primaire doelgroep

- studenten
- zelfstandigen
- developers
- ondernemers
- mensen met veel kleine taken
- mensen die vaak ideeën krijgen
- mensen die productiever willen werken

### Secundaire doelgroep

- gebruikers die klassieke notitie-apps te zwaar vinden
- mensen die snel dingen vergeten
- gebruikers die graag een eenvoudige dagelijkse review doen
- gebruikers die een minimalistische productiviteitsapp zoeken

---

## Kernidee

FlowNote werkt als een snelle mentale inbox.

De gebruiker hoeft niet na te denken over categorieën, mappen of structuur. Alles wordt eerst gewoon opgeslagen. Pas later beslist de gebruiker wat ermee moet gebeuren.

De basisflow is:

1. Open de app.
2. Typ of spreek een gedachte in.
3. Sla op.
4. Ga verder met je dag.
5. Verwerk alles later in de Daily Review.

De kracht van de app zit niet in veel functies, maar in het wegnemen van frictie.

---

## Belangrijkste functionaliteiten

## 1. Quick Capture

Quick Capture is het hoofdscherm van de app en de belangrijkste functionaliteit.

Wanneer de gebruiker de app opent, staat het invoerveld direct klaar. Het toetsenbord opent automatisch, zodat de gebruiker meteen kan typen.

### Functionaliteiten

- groot tekstveld
- automatische focus op het invoerveld
- toetsenbord opent automatisch
- opslaan met één duidelijke knop
- leegmaken van invoerveld na opslaan
- animatie of subtiele bevestiging na opslaan
- ondersteuning voor korte en langere teksten

### Doel

De gebruiker moet binnen twee seconden een gedachte kunnen vastleggen.

### Voorbeeldgebruik

Een gebruiker denkt plots:

> “Ik moet vrijdag die meeting voorbereiden.”

De gebruiker opent FlowNote, typt deze zin en drukt op **Opslaan**. Het item staat direct in de lijst.

---

## 2. Lijst van items

Alle opgeslagen gedachten worden getoond in een overzichtelijke lijst.

### Functionaliteiten

- chronologische lijst
- nieuwste item bovenaan
- groepering per dag
- korte preview van de inhoud
- tijdstip per item
- statusweergave: open, voltooid of bewaard

### Interacties

- tikken op item opent detailweergave
- swipe naar rechts markeert item als voltooid
- swipe naar links verwijdert item
- long press kan extra opties tonen

### Doel

De lijst geeft overzicht zonder complexiteit.

---

## 3. Item detail

In de detailweergave kan de gebruiker een specifiek item bekijken en beheren.

### Functionaliteiten

- volledige tekst bekijken
- item bewerken
- item verwijderen
- item markeren als voltooid
- datum en tijd bekijken
- eventueel notitie uitbreiden

### Mogelijke acties

- **Bewerken**: gebruiker kan de tekst aanpassen
- **Voltooid**: item wordt gemarkeerd als afgewerkt
- **Verwijderen**: item wordt permanent verwijderd

### Doel

De detailpagina blijft eenvoudig en toont enkel wat nodig is.

---

## 4. Daily Review

Daily Review is een van de belangrijkste productiviteitsfuncties van FlowNote.

Aan het einde van de dag krijgt de gebruiker een overzicht van alles wat hij of zij die dag heeft opgeslagen.

### Functionaliteiten

- overzicht van alle items van vandaag
- items selecteren
- item markeren als voltooid
- item bewaren voor later
- item verwijderen
- aantal items van de dag tonen

### Mogelijke acties per item

- **Voltooid**: het item is afgewerkt
- **Bewaren**: het item blijft actief voor later
- **Verwijderen**: het item is niet meer nodig

### Doel

Daily Review voorkomt dat de app een eindeloze rommellijst wordt. De gebruiker verwerkt dagelijks zijn mentale inbox.

---

## 5. Zoekfunctie

De zoekfunctie helpt gebruikers om snel eerdere items terug te vinden.

### Functionaliteiten

- realtime zoeken
- zoeken op inhoud
- resultaten direct tonen
- zoeken zonder op enter te drukken
- overzichtelijke resultaatlijst

### Voorbeeld

De gebruiker zoekt op:

> “meeting”

FlowNote toont direct alle items waarin het woord “meeting” voorkomt.

---

## 6. Spraakinvoer

Spraakinvoer maakt het mogelijk om snel gedachten vast te leggen zonder te typen.

### Functionaliteiten

- microfoonknop op het capture-scherm
- opname starten
- spraak omzetten naar tekst
- tekst tonen in het invoerveld
- gebruiker kan tekst aanpassen voor opslaan

### Doel

Spraakinvoer maakt FlowNote bruikbaar onderweg, in de auto, tijdens een wandeling of wanneer typen niet handig is.

---

## 7. Widget

De widget geeft snelle toegang tot FlowNote vanaf het startscherm van de telefoon.

### Functionaliteiten

- knop “Nieuwe gedachte”
- opent direct het Quick Capture scherm
- cursor staat klaar
- eventueel korte preview van laatste items

### Doel

De widget verlaagt de drempel om iets vast te leggen.

---

## 8. Instellingen

De instellingen blijven bewust beperkt.

### Functionaliteiten

- thema kiezen: licht of donker
- notificaties aan- of uitzetten
- uur van Daily Review instellen
- widget tonen of verbergen
- backup en export

### Doel

Gebruikers mogen de app personaliseren, maar de instellingen mogen de eenvoud niet verstoren.

---

# Onboarding flow

De onboarding is kort, visueel en gericht op direct gebruik. De gebruiker moet niet eerst een lange uitleg lezen.

De onboarding bestaat uit maximaal vier schermen.

---

## Onboarding scherm 1 — Welkom

### Titel

**Welkom bij FlowNote**

### Tekst

Leg gedachten, taken en ideeën vast zodra ze in je hoofd komen.

### Visueel

Een minimalistische illustratie of mockup van het Quick Capture scherm.

### Knop

**Start**

### Doel

De gebruiker begrijpt meteen waar de app voor dient.

---

## Onboarding scherm 2 — Leg snel vast

### Titel

**Binnen enkele seconden opgeslagen**

### Tekst

Open de app, typ wat in je hoofd zit en sla het direct op. Geen mappen, geen afleiding.

### Visueel

Een invoerveld met voorbeeldtekst:

> “Mail sturen naar klant”

### Knop

**Volgende**

### Doel

De gebruiker begrijpt de Quick Capture functie.

---

## Onboarding scherm 3 — Verwerk je dag

### Titel

**Review je gedachten op het einde van de dag**

### Tekst

Bekijk wat je vandaag hebt opgeslagen en beslis wat klaar is, wat bewaard moet worden en wat weg mag.

### Visueel

Een Daily Review checklist.

### Knop

**Volgende**

### Doel

De gebruiker begrijpt dat FlowNote niet enkel opslaat, maar ook helpt opruimen.

---

## Onboarding scherm 4 — Notificatie instellen

### Titel

**Wanneer wil je je Daily Review doen?**

### Tekst

Kies een vast moment waarop FlowNote je eraan herinnert om je dag kort te verwerken.

### Opties

- 18:00
- 20:00
- 21:30
- Zelf kiezen
- Overslaan

### Knop

**FlowNote gebruiken**

### Doel

De gebruiker stelt meteen een gewoonte in.

---

## Onboarding afsluiten

Na de onboarding komt de gebruiker direct op het Quick Capture scherm.

Het invoerveld is actief en de gebruiker kan meteen zijn eerste gedachte opslaan.

### Eerste placeholder

> Wat zit er in je hoofd?

---

# App schermen

## 1. Quick Capture scherm

### Doel

Snel gedachten vastleggen.

### Layout

- appnaam bovenaan
- subtiele knop voor instellingen of menu
- titelvraag: “Wat zit er in je hoofd?”
- groot tekstveld
- microfoonknop
- opslaanknop
- onderste navigatiebalk

### Belangrijke UX-regels

- invoerveld krijgt automatisch focus
- opslaanknop is pas actief wanneer er tekst is
- na opslaan verschijnt korte feedback
- gebruiker blijft op hetzelfde scherm

---

## 2. Alle items scherm

### Doel

Overzicht geven van opgeslagen items.

### Layout

- titel: “Alle items”
- zoekicoon bovenaan
- items gegroepeerd per dag
- elk item toont tijdstip en preview
- bottom navigation blijft zichtbaar

### Item layout

Elk item bevat:

- tijdstip
- eerste regels van de tekst
- optioneel statusicoon

---

## 3. Detail scherm

### Doel

Een item bekijken en beheren.

### Layout

- terugknop
- optiemenu
- grote tekstweergave
- datum en tijd
- actiekoppen onderaan

### Acties

- verwijderen
- bewerken
- voltooid markeren

---

## 4. Daily Review scherm

### Doel

Dagelijkse verwerking van opgeslagen items.

### Layout

- titel: “Review van vandaag”
- korte samenvatting
- lijst met items
- selectiecirkel per item
- knop onderaan: “Voltooid”

### Gedrag

- gebruiker kan één of meerdere items selecteren
- geselecteerde items kunnen verwerkt worden
- onderaan wordt aantal geselecteerde items getoond

---

## 5. Zoekscherm

### Doel

Snel informatie terugvinden.

### Layout

- zoekveld bovenaan
- resultatenlijst
- lege staat wanneer niets gevonden is

### Lege staat

Tekst:

> Geen resultaten gevonden.

---

## 6. Spraakinvoer scherm

### Doel

Gedachten inspreken in plaats van typen.

### Layout

- sluitknop
- tekst “Ik luister...”
- animatie van audiogolf
- grote microfoonknop
- knop om toetsenbord te gebruiken

### Gedrag

- gebruiker start opname
- spraak wordt omgezet naar tekst
- gebruiker kan tekst opslaan of aanpassen

---

## 7. Widget

### Doel

Directe toegang vanaf het startscherm.

### Layout

- appnaam
- korte tekst: “Nieuwe gedachte vastleggen”
- knop: “Nieuwe note”

### Gedrag

Tik op widget opent direct het Quick Capture scherm.

---

## 8. Instellingen scherm

### Doel

Basisvoorkeuren beheren.

### Layout

Groepen:

1. Algemeen
2. Widget
3. Gegevens

### Opties

- thema
- notificaties
- tijdstip Daily Review
- widget tonen
- backup en export

---

# Gebruikersflow

## Dagelijkse flow

1. Gebruiker opent FlowNote.
2. Gebruiker schrijft een gedachte neer.
3. Item wordt opgeslagen.
4. Gebruiker doet dit meerdere keren per dag.
5. ’s Avonds krijgt gebruiker een Daily Review.
6. Gebruiker verwerkt de items.
7. De app blijft overzichtelijk.

---

## Flow voor snelle gedachte

1. Open app.
2. Typ gedachte.
3. Druk op opslaan.
4. App wist invoerveld.
5. Gebruiker kan direct verder.

---

## Flow voor zoeken

1. Gebruiker opent tab “Zoek”.
2. Gebruiker typt zoekterm.
3. Resultaten verschijnen direct.
4. Gebruiker opent relevant item.

---

## Flow voor review

1. Gebruiker opent Daily Review.
2. FlowNote toont items van vandaag.
3. Gebruiker selecteert items.
4. Gebruiker kiest actie.
5. Review wordt afgerond.

---

# Designvisie

FlowNote gebruikt een moderne, rustige en minimalistische designstijl.

De app moet voelen als:

- snel
- rustig
- betrouwbaar
- professioneel
- niet overweldigend

## Kleuren

### Licht thema

- Achtergrond: `#FFFFFF`
- Primaire tekst: `#111111`
- Secundaire tekst: `#6B7280`
- Accentkleur: `#7C5CFF`
- Kaartachtergrond: `#F7F7FA`
- Lijnen: `#E5E7EB`

### Donker thema

- Achtergrond: `#0F0F12`
- Kaartachtergrond: `#1A1A1F`
- Primaire tekst: `#FFFFFF`
- Secundaire tekst: `#A1A1AA`
- Accentkleur: `#8B7CFF`

## Typografie

- Font: system font / SF Pro
- Grote titels: 28–34 pt
- Sectietitels: 18–22 pt
- Body tekst: 15–17 pt
- Kleine labels: 12–13 pt

## Componenten

### Knoppen

- afgeronde hoeken
- duidelijke accentkleur
- subtiele schaduw
- korte labels

### Tekstvelden

- groot
- rustig
- zonder harde randen
- placeholdertekst in lichtgrijs

### Lijsten

- duidelijke spacing
- geen visuele drukte
- subtiele scheidingslijnen

---

# Navigatiestructuur

FlowNote gebruikt een bottom navigation met vier hoofdtabbladen.

## Tabs

1. **Capture**
2. **Lijst**
3. **Review**
4. **Zoek**

### Capture

Het hoofdscherm voor nieuwe input.

### Lijst

Overzicht van alle opgeslagen items.

### Review

Dagelijkse verwerking van items.

### Zoek

Snel terugvinden van oude items.

---

# Datamodel

## Entity: DumpItem

Een DumpItem stelt één opgeslagen gedachte, taak of idee voor.

### Velden

| Veld | Type | Beschrijving |
|---|---|---|
| id | UUID | Unieke identifier |
| content | String | Inhoud van het item |
| createdAt | Date | Datum en tijd van aanmaak |
| updatedAt | Date | Laatste wijziging |
| status | Enum | open, completed, archived |
| isPinned | Boolean | Item bewaren voor later |
| source | Enum | text, voice, widget |

---

## Statussen

### Open

Het item is nog niet verwerkt.

### Completed

Het item is afgewerkt.

### Archived

Het item is bewaard maar niet meer actief.

---

# MVP-scope

De eerste versie van FlowNote moet bewust klein blijven.

## In MVP

- Quick Capture
- items opslaan
- lijst tonen
- item verwijderen
- item markeren als voltooid
- zoeken
- Daily Review
- eenvoudige instellingen

## Niet in MVP

- AI-functies
- complexe tags
- teamsamenwerking
- uitgebreide mappenstructuur
- sociale functies
- kalenderintegratie

---

# Uitbreidingen zonder AI

## 1. Manuele tags

Gebruikers kunnen zelf tags toevoegen zoals:

- werk
- school
- boodschappen
- idee
- persoonlijk

## 2. Favorieten

Belangrijke items kunnen gemarkeerd worden als favoriet.

## 3. Archief

Afgewerkte of oude items kunnen naar een archief.

## 4. Export

Gebruiker kan items exporteren naar:

- tekstbestand
- CSV
- PDF

## 5. iCloud synchronisatie

Items worden gesynchroniseerd tussen iPhone, iPad en eventueel Mac.

## 6. Donkere modus

De app ondersteunt een donker thema.

## 7. Herinneringen

Gebruiker kan handmatig een reminder toevoegen aan een item.

## 8. Herbruikbare templates

Voorbeelden:

- snelle taak
- idee
- meetingnotitie
- boodschappen

---

# Notificaties

FlowNote gebruikt notificaties enkel wanneer ze waarde toevoegen.

## Daily Review notificatie

Een dagelijkse herinnering om items te verwerken.

Voorbeeld:

> Tijd voor je FlowNote review. Verwerk kort wat vandaag in je hoofd zat.

## Reminder notificatie

Wanneer gebruiker later handmatig reminders toevoegt.

Voorbeeld:

> Vergeet niet: mail sturen naar klant.

## Notificatieprincipes

- geen spam
- maximaal relevant
- gebruiker bepaalt tijdstip
- notificaties zijn optioneel

---

# Privacy en opslag

FlowNote bevat persoonlijke gedachten en taken. Privacy is daarom belangrijk.

## Lokale opslag

In de basisversie worden alle items lokaal op het toestel opgeslagen.

## Geen externe verwerking

Zonder AI-functies hoeft geen inhoud naar externe servers gestuurd te worden.

## Backup

Optioneel kan de gebruiker later kiezen voor:

- iCloud backup
- lokale export
- handmatige backup

## Privacyprincipes

- gebruiker blijft eigenaar van data
- geen tracking van inhoud
- geen verkoop van data
- transparante opslag

---

# Technische aanpak

## Aanbevolen platform

Voor de eerste versie is een native iOS-app logisch.

### Aanbevolen stack

- SwiftUI
- MVVM architectuur
- CoreData of SwiftData
- UserNotifications framework
- Speech framework voor spraakinvoer
- WidgetKit voor homescreen widget

---

## Architectuur

De app kan opgebouwd worden volgens MVVM.

### Model

Bevat de datastructuren zoals DumpItem.

### View

Bevat de SwiftUI-schermen.

### ViewModel

Bevat de logica tussen data en interface.

### Services

Bevat aparte logica voor opslag, notificaties, speech en export.

---

# Mogelijke mappenstructuur

```text
FlowNote/
│
├── App/
│   └── FlowNoteApp.swift
│
├── Models/
│   └── DumpItem.swift
│
├── ViewModels/
│   ├── CaptureViewModel.swift
│   ├── ItemListViewModel.swift
│   ├── ReviewViewModel.swift
│   └── SearchViewModel.swift
│
├── Views/
│   ├── Capture/
│   │   └── CaptureView.swift
│   ├── List/
│   │   ├── ItemListView.swift
│   │   └── ItemRowView.swift
│   ├── Detail/
│   │   └── ItemDetailView.swift
│   ├── Review/
│   │   └── DailyReviewView.swift
│   ├── Search/
│   │   └── SearchView.swift
│   ├── Settings/
│   │   └── SettingsView.swift
│   └── Onboarding/
│       ├── OnboardingView.swift
│       └── OnboardingPageView.swift
│
├── Services/
│   ├── StorageService.swift
│   ├── NotificationService.swift
│   ├── SpeechService.swift
│   └── ExportService.swift
│
├── Components/
│   ├── PrimaryButton.swift
│   ├── EmptyStateView.swift
│   └── BottomTabBar.swift
│
├── Resources/
│   ├── Assets.xcassets
│   └── Localizable.strings
│
└── Widget/
    └── FlowNoteWidget.swift
```

---

# Roadmap

## Versie 1.0 — MVP

- onboarding
- Quick Capture
- opslaan van items
- lijstweergave
- detailweergave
- verwijderen
- voltooid markeren
- zoeken
- Daily Review
- basisinstellingen

## Versie 1.1

- spraakinvoer
- widget
- dark mode
- betere animaties

## Versie 1.2

- manuele tags
- favorieten
- archief
- export

## Versie 2.0

- iCloud sync
- iPad ondersteuning
- Mac ondersteuning
- geavanceerde filtering

---

# Monetisatie

FlowNote kan als freemium-app worden aangeboden.

## Gratis versie

- onbeperkt items opslaan
- zoeken
- Daily Review
- basisinstellingen

## Premium versie

- iCloud sync
- export
- geavanceerde filters
- extra thema’s
- widgets
- archief

## Mogelijke prijs

- eenmalige aankoop: €4,99
- of abonnement: €1,99 per maand

Voor een app als FlowNote is een eenmalige aankoop waarschijnlijk toegankelijker en gebruiksvriendelijker.

---

# Waarom FlowNote sterk is

FlowNote is sterk omdat het een herkenbaar probleem oplost zonder complex te worden.

Veel productiviteitsapps proberen te veel tegelijk te doen. FlowNote kiest bewust voor één duidelijke taak:

> Gedachten snel vastleggen en later verwerken.

Daardoor is de app:

- makkelijk te begrijpen
- snel in gebruik
- dagelijks relevant
- geschikt voor een brede doelgroep
- goed uitbreidbaar

---

# Conclusie

FlowNote is een moderne Brain Dump app die gebruikers helpt om gedachten, taken en ideeën snel vast te leggen en dagelijks te verwerken.

De app combineert:

- snelheid
- eenvoud
- overzicht
- dagelijkse reflectie
- minimalistisch design

FlowNote is geen zware notitie-app, maar een rustige productiviteitstool die gebruikers helpt hun hoofd leeg te maken en beter te focussen.

