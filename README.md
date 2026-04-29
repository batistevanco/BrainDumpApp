# Brainox

Brainox is een minimalistische iPhone-app om gedachten, taken, ideeen en dingen die je wil onthouden snel uit je hoofd te halen. De app is gebouwd rond een eenvoudige belofte:

> Hoofd leeg. Dag helder.

Deze README is bedoeld als product- en technische briefing voor een volgende agent die Brainox later op een website moet uitleggen of presenteren.

## Korte Positionering

Brainox is een rustige capture-app voor mensen die veel losse gedachten in hun hoofd hebben. In plaats van een zware takenplanner te zijn, focust Brainox op snelle invoer, korte verwerking en overzicht. De gebruiker schrijft of dicteert wat in zijn hoofd zit, kiest optioneel of het een taak, idee of onthouden-item is, en verwerkt alles later in een Daily Review.

Brainox past het best in de categorie productiviteit, focus en persoonlijke organisatie.

## Website Samenvatting

Brainox helpt je om losse gedachten meteen vast te leggen, zonder gedoe. Open de app, schrijf of dicteer wat in je hoofd zit, kies eventueel een type en ga verder met je dag. Later helpt Daily Review je om alles rustig te verwerken: afronden, bewaren of weggooien.

De app bewaart gegevens lokaal op de iPhone en is ontworpen als een rustige, native iOS-ervaring met duidelijke navigatie, compacte vormgeving en ondersteuning voor iOS Liquid Glass waar beschikbaar.

## Voor Wie

- Mensen die snel taken, ideeen of reminders willen parkeren.
- Zelfstandigen, studenten en kenniswerkers die veel context moeten vasthouden.
- Gebruikers die geen zware projectmanagement-app nodig hebben.
- Mensen die graag met een dagelijkse review werken.
- Nederlandstalige gebruikers, met dictatie ingesteld op `nl-BE`.

## Kernfeatures

### Quick Capture

Het hoofdscherm heet `Capture` en toont de vraag: `Wat zit er in je hoofd?`. Daaronder staat de datum, gevolgd door een groot tekstvak. De gebruiker kan meteen een gedachte typen of dicteren.

Bij capture kan een item optioneel een type krijgen:

- `Taak`
- `Idee`
- `Onthoud`

Na opslaan wordt het item lokaal bewaard en wordt het invoerveld leeggemaakt.

### Dictatie

Brainox ondersteunt spraak naar tekst via Apple Speech en AVFoundation. De herkenning gebruikt de locale `nl-BE`.

In de instellingen kan de gebruiker:

- dictatie aan- of uitzetten;
- kiezen of dictatie automatisch stopt na verzenden.

De standaardinstelling is dat dictatie stopt zodra de gebruiker een item opslaat.

### Daily Review

Daily Review helpt de gebruiker om items van vandaag te verwerken. Open items komen in de reviewqueue. De gebruiker kan items afronden, bewaren of verwijderen.

Statussen:

- `open`
- `voltooid`
- `bewaard`

De review bevat progressie en gebruikt de dagelijkse reviewtijd uit de instellingen.

### Lijst

De lijst toont opgeslagen items chronologisch. Items kunnen bekeken, bewerkt en verwerkt worden. De app toont ook weekstatistieken zoals het aantal items en verwerkte items.

### Zoek

De zoekpagina laat de gebruiker snel door opgeslagen gedachten zoeken. Het zoekveld krijgt niet automatisch focus bij openen, zodat het keyboard niet ongewenst verschijnt.

### Detailweergave

Een item kan geopend worden in detail. Daar kan de tekst aangepast worden en kan de status gewijzigd worden naar afgerond, bewaard of verwijderd.

### Instellingen

De instellingen bevatten:

- appkaart met naam, slogan, versie en buildnummer;
- statistieken voor vandaag, review en totaal;
- tekstgrootte: `Small`, `Default`, `Large`;
- weergavemodus: systeem, licht of donker;
- dictatie-instellingen;
- Daily Review tijdstip en reminder;
- backup export/import;
- onboarding opnieuw tonen;
- support en privacy links.

De versie en build worden live uit de app-bundel gelezen:

- `CFBundleShortVersionString`
- `CFBundleVersion`

## Navigatie En Design

Brainox gebruikt een native SwiftUI `NavigationStack` en `TabView`.

Tabs:

- `Capture`
- `Lijst`
- `Review`
- `Zoek`

Omdat de app native SwiftUI navigatie en tabbars gebruikt, kan iOS automatisch de moderne Liquid Glass navigatie- en tabbalk toepassen op ondersteunde iOS-versies.

Het design is rustig, licht, compact en gericht op focus. Belangrijke UI-kenmerken:

- grote maar niet overdreven capture-zone;
- zachte kaartachtergronden;
- afgeronde knoppen;
- SF Symbols voor iconen;
- mascotte linksboven op het capture-scherm;
- geen drukke marketingstijl in de app zelf;
- ondersteuning voor licht/donker/systeemweergave.

## Keyboardgedrag

Het keyboard mag niet automatisch verschijnen bij het openen van de app. Het scherm mag ook niet verspringen zodra het keyboard verschijnt.

Huidige UX-regels:

- capture en zoek krijgen niet automatisch focus;
- tikken buiten het invoerveld verbergt het keyboard;
- swipen op het scherm verbergt het keyboard;
- het scherm negeert keyboard safe-area verschuivingen waar nodig;
- acties zoals opslaan sluiten focus af.

## Privacy En Data

Brainox is ontworpen als lokale app zonder backend.

Opslag:

- items worden lokaal als JSON bewaard in de documents-directory;
- bestandsnaam: `braindump-items.json`;
- backups worden geexporteerd als JSON-document;
- backup-extensie: `.braindump`;
- exported UTType: `be.vancoillie.braindump.backup`.

Permissions:

- microfoon voor dictatie;
- speech recognition voor spraak naar tekst;
- notificaties voor Daily Review reminders.

Er is geen account, server of cloud-sync in de huidige appcode.

Privacy URL:

`https://www.vancoillieithulp.be/privacyPolicyBrainox.html`

Support:

`support@vancoilliestudio.be`

## Technische Context

Project:

- Xcode project: `BrainDump.xcodeproj`
- App target: `BrainDump`
- Display name: `Brainox`
- Bundle identifier: `be.vancoillie.braindump`
- Marketing version: `1.0`
- Current project version/build: `8`
- iOS deployment target voor de app: `18.6`
- App category: `public.app-category.productivity`

Frameworks en API's:

- SwiftUI
- Combine via `ObservableObject`/`@Published`
- `@AppStorage`
- UserNotifications
- Speech
- AVFoundation
- UniformTypeIdentifiers

Belangrijke codegebieden:

- `BrainDump/BrainDumpApp.swift`
- `BrainDump/Views/RootView.swift`
- `BrainDump/Views/MainShellView.swift`
- `BrainDump/Views/Tabs/CaptureView.swift`
- `BrainDump/Views/Tabs/ItemsListView.swift`
- `BrainDump/Views/Tabs/DailyReviewView.swift`
- `BrainDump/Views/Tabs/SearchView.swift`
- `BrainDump/Views/Settings/SettingsView.swift`
- `BrainDump/Store/BrainDumpStore.swift`
- `BrainDump/Store/SpeechController.swift`
- `BrainDump/Models/FlowItem.swift`
- `BrainDump/Models/BrainDumpBackup.swift`
- `BrainDump/DesignSystem/BrainDumpStyle.swift`

## Datamodel

`FlowItem`:

- `id: UUID`
- `text: String`
- `type: FlowItemType?`
- `createdAt: Date`
- `updatedAt: Date`
- `status: FlowItemStatus`
- `reviewedAt: Date?`

`FlowItemType`:

- `taak`
- `idee`
- `onthoud`

`FlowItemStatus`:

- `open`
- `completed`
- `saved`

`BrainDumpBackup`:

- `exportedAt`
- `items`
- `reviewHour`
- `reviewMinute`

## Instellingen In AppStorage

Brainox gebruikt onder meer deze `@AppStorage` keys:

- `hasCompletedOnboarding`
- `reviewHour`
- `reviewMinute`
- `isDictationEnabled`
- `stopDictationAfterSave`
- `textSizePreference`
- `colorSchemePreference`

Tekstgroottes:

- `small`: schaal `0.88`
- `default`: schaal `1.0`
- `large`: schaal `1.16`

## Tests

Er is een testtarget `BrainDumpTests` met tests voor:

- toevoegen, trimmen en bewaren van items;
- updaten van items;
- status wijzigen;
- verwijderen;
- today/review filtering;
- backup JSON roundtrip.

Bestanden:

- `BrainDumpTests/BrainDumpStoreTests.swift`
- `BrainDumpTests/BrainDumpBackupTests.swift`

Let op voor toekomstige agents: controleer de test `testTodayItemsAndReviewQueueFilterStatuses`. De huidige appcode gebruikt een reviewqueue met alleen `open` items. Als de test nog `saved` items in de queue verwacht, moet de test worden aangepast aan het gewenste productgedrag.

## Build En QA

Typische buildcommand:

```sh
xcodebuild -project BrainDump.xcodeproj -scheme BrainDump -configuration Debug -sdk iphoneos -destination 'generic/platform=iOS' -derivedDataPath ./DerivedData CODE_SIGNING_ALLOWED=NO build
```

Typische testcommand:

```sh
xcodebuild test -project BrainDump.xcodeproj -scheme BrainDump -configuration Debug -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 17' -derivedDataPath ./DerivedData
```

Bekende QA-aandachtspunten:

- App-icon assets zijn aanwezig in `BrainDump/Assets.xcassets/AppIcon.appiconset`.
- Er bestaat ook een widgettarget: `BrainDumpWidgetExtension`.
- Controleer bij archiveren dat app en widget hetzelfde buildnummer hebben.
- Controleer steeds op echt toestel of keyboardgedrag, dictatie en notificaties correct werken.

## Website Copy Suggesties

### Hero

Titel:

`Brainox`

Subtitle:

`Hoofd leeg. Dag helder.`

Korte tekst:

`Leg taken, ideeen en losse gedachten meteen vast. Brainox helpt je snel capteren en later rustig verwerken.`

CTA suggesties:

- `Ontdek Brainox`
- `Bekijk privacy`
- `Contact voor support`

### Featureblokken

`Snel vastleggen`

Open Brainox, typ of dicteer wat in je hoofd zit en sla het op zonder extra stappen.

`Rustige Daily Review`

Verwerk je gedachten later: rond af, bewaar of verwijder wat niet meer nodig is.

`Lokaal en simpel`

Je data blijft op je iPhone. Exporteren en importeren kan via een lokale backup.

`Gemaakt voor iPhone`

Brainox gebruikt native iOS-navigatie, duidelijke tabs en een rustige interface die meebeweegt met je instellingen.

### Langere Producttekst

Brainox is geen zware takenmanager. Het is een mentale inbox voor alles wat even uit je hoofd moet. Een taak voor later, een idee dat je niet wil verliezen, een reminder die plots opkomt: je zet het snel in Brainox en verwerkt het wanneer jij daar ruimte voor hebt.

Met Daily Review bouw je een klein ritueel in. Alles wat vandaag open staat, komt terug op het juiste moment. Zo blijft je hoofd rustiger en blijft de app eenvoudig.

## Wat Niet Overclaimen

Gebruik op de website geen claims die niet in de huidige app zitten:

- geen AI-functionaliteit claimen;
- geen cloud-sync claimen;
- geen samenwerking of teams claimen;
- geen Android-versie claimen;
- geen volledige projectmanagementsuite claimen.

Brainox is vandaag vooral sterk als snelle, lokale, rustige iPhone-capture-app.

