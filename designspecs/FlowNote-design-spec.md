# FlowNote — Design Specification

Dit document beschrijft het visuele ontwerp van FlowNote en is bedoeld als brief voor een AI of designer om het ontwerp na te bouwen in SwiftUI of een andere stack.

---

## Designfilosofie

FlowNote is een minimalistische brain-dump app. Het ontwerp volgt drie principes:

1. **Wit als basis, zwart als enige accent.** Geen kleurenpalet voor statussen of categorieën — alles communiceert via typografie, opacity en vormvariatie.
2. **Kaarten in plaats van scheidingslijnen.** Elke unit van content (gedachte, optie, item) zit in een lichtgrijze pill-card met afgeronde hoeken.
3. **Eén primaire actie per scherm.** De zwarte pill-knop onderaan is altijd de hoofdactie. Secundaire acties zijn ofwel grijs ofwel transparante tekst.

---

## Kleurenpalet

| Rol | Hex | Gebruik |
|---|---|---|
| Achtergrond primair | `#FFFFFF` | App background, kaart-binnenkant in review |
| Achtergrond secundair | `#F7F7FA` | Pill-cards, input fields, inactieve knoppen |
| Achtergrond tertiair | `#F1EFE8` | Stage/canvas achter de telefoon (alleen mockup) |
| Tekst primair | `#111111` | Hoofdtekst, accenten, actieve nav-items |
| Tekst secundair | `#6B7280` | Tijdstempels, meta-info, helper text |
| Tekst tertiair | `#9CA3AF` | Inactieve nav-labels, "Overslaan", placeholder |
| Lijnen | `#E5E7EB` | Bottom-nav border, progress dots inactief |
| Succes (subtiel) | `#1D9E75` | Alleen in onboarding "Klaar in 2 seconden" microcopy |

**Geen andere kleuren.** Status (open, voltooid, bewaard) wordt gecommuniceerd via:
- doorstrepen van tekst (voltooid)
- opacity 0.55 (voltooid in lijst)
- font-weight 500 op het statuswoord zelf

---

## Typografie

- Font: **SF Pro** (iOS systeemfont)
- Twee gewichten: **400 regular**, **500 medium**. Geen bold (700).
- Sentence case overal. Geen Title Case, geen ALL CAPS — behalve de mini-section labels die `text-transform: uppercase` + `letter-spacing: 0.5px` gebruiken op 11px.

| Element | Size | Weight | Color |
|---|---|---|---|
| Schermtitel (H1) | 22–24px | 500 | `#111111` |
| Body | 14–15px | 400 | `#111111` |
| Meta / timestamp | 11–13px | 400 | `#6B7280` |
| Section label (uppercase) | 11px | 500 | `#9CA3AF` of `#111111` |
| Knop-label | 16px (primair) / 12px (review acties) | 500 | wit op zwart, of `#111111` |
| Tab label | 10px | 400 (inactief) / 500 (actief) | `#9CA3AF` / `#111111` |

---

## Spacing & layout

- **Telefoon-frame:** 280px breed, 580px hoog, `border-radius: 32px`
- **Schermpadding:** 20px horizontaal voor headers, 16–20px voor content
- **Kaart-padding:** 12–16px
- **Border-radius:**
  - Pill-cards (lijst): `12px`
  - Input/review-cards: `14–16px`
  - Knoppen primair: `14px`
  - Knoppen klein (review acties): `10px`
  - Iconcontainer notificatie: `18px`
  - Status-cirkels avatar/check: `50%`
- **Verticaal ritme tussen kaarten:** 8px
- **Verticaal ritme tussen secties:** 16px

---

## Componenten

### Status bar (fake)
`9:41` links, batterij-rectangle rechts (14×8px, 1px border, radius 2px). Padding: `12px 20px 4px`. Color: `#111111`.

### Bottom navigation
4 tabs: Capture, Lijst, Review, Zoek. Border-top `0.5px solid #E5E7EB`. Padding `10px 0 18px`. Per tab:
- icon 20×20 (stroke-width 1.8, stroke-linecap round)
- label 10px eronder, 3px gap
- actief: stroke + tekst `#111111`, weight 500
- inactief: stroke + tekst `#9CA3AF`, weight 400

Icoon-paths:
- **Capture:** cirkel + plus binnenin
- **Lijst:** drie horizontale lijnen, derde korter
- **Review:** vinkje (polyline)
- **Zoek:** vergrootglas

### Pill-card (lijst-item)
```
background: #F7F7FA
border-radius: 12px
padding: 12px 14px
margin-bottom: 8px
```
Body 14px `#111111`, daaronder 6px gap, dan timestamp 11px `#6B7280` met format: `14:23 · open`. Voltooid: opacity 0.55 + `text-decoration: line-through` op de body. Status-woord in 500 weight `#111111`.

### Input field (Capture)
```
background: #F7F7FA
border-radius: 16px
padding: 14px 16px
min-height: 140px
```
Tekst 15px met `line-height: 1.5`. Cursor: 1.5px breed, 16px hoog, `#111111`, blink-animatie 1s. Karakter-counter onderaan in 12px `#6B7280`.

### Primaire knop
```
background: #111111
color: #FFFFFF
border: none
border-radius: 14px
padding: 14px
font-size: 16px
font-weight: 500
width: 100% (in onboarding/capture)
```

### Review-actieknoppen (3 op een rij)
```
flex: 1, gap: 6px
border-radius: 10px
padding: 10px 4px
font-size: 12px, weight 500
```
- Primaire (Klaar): zwart bg, witte tekst
- Secundaire (Bewaar): `#F7F7FA` bg, `#111111` tekst
- Destructieve (Weg): `#F7F7FA` bg, `#6B7280` tekst

### Review-kaart (actief item)
```
background: #FFFFFF
border: 1.5px solid #111111
border-radius: 16px
padding: 16px
```
Kleine label boven (`VANDAAG · 14:23`) in 11px 500 `#111111`, dan 6px gap, dan body 15px, dan 14px gap, dan actie-rij.

### Optie-kaart (notificatie kiezen)
```
background: #F7F7FA (niet-geselecteerd) / #FFFFFF (geselecteerd)
border: 1px transparent / 1.5px solid #111111
border-radius: 12px
padding: 14px 16px
```
Geselecteerd item heeft een vinkje-cirkel rechts (16×16, gevuld zwart, witte check).

### Progress dots (onboarding)
4 dots, 6px gap. Inactief: `5×5px` cirkel `#E5E7EB`. Actief: `18×5px` pill `border-radius: 3px` `#111111`.

### Progress bar (Daily Review)
Track `#F7F7FA`, height 6px, radius 3px. Fill `#111111` met breedte = `(verwerkt / totaal) × 100%`.

### Voltooid-cirkel (klein)
14×14 of 16×16, `fill: #111111`, witte vinkje polyline binnenin met `stroke-width: 1.5` en round caps/joins.

---

## Animaties

- **Cursor blink:** 1s interval, 50/50 zichtbaar/onzichtbaar
- **Knoppen tap:** scale `0.97` op active state, 100ms ease-out
- **Item afgevinkt in review:** fade naar opacity 0.5 + slide naar onder, 250ms cubic-bezier(0.4, 0, 0.2, 1)
- **Capture opslaan:** korte haptic + invoerveld leegt met fade, 200ms

---

## Schermenoverzicht

### Onboarding (4 schermen)
1. **Welkom** — drie schuin-gestapelde voorbeeld-kaarten (-2°, 0°, +2°), middelste geaccentueerd met 1px zwarte rand. Titel "Welkom bij FlowNote", subtekst, "Start"-knop.
2. **Snel vastleggen** — input field met voorbeeldtekst "Mail sturen naar klant" + blink-cursor + groene microbevestiging.
3. **Daily Review uitleg** — mini checklist met 3 items in 3 statussen (voltooid/bewaard/actief) + 3 disabled action pills eronder.
4. **Notificatie** — klok-icoon in 56×56 grijze rounded square, 4 tijd-opties waarvan 20:00 voorgeselecteerd, met context-labels naast 18:00 en 21:30.

Alle onboarding-schermen hebben:
- "Overslaan" rechtsboven (behalve scherm 1: alleen rechts) en "← Terug" linksboven (behalve scherm 1)
- Progress dots boven de knop
- Volledige-breedte zwarte primaire knop onderaan

### Hoofdschermen (3 schermen)
1. **Capture** — datum + "Wat zit er in je hoofd?" header, groot input field, Opslaan-knop, dicteer-optie eronder.
2. **Lijst** — items gegroepeerd per dag ("Vandaag", "Gisteren") in pill-cards.
3. **Daily Review** — actieve item-kaart bovenaan met 3 acties, daaronder volgende item (faded) en al verwerkt item (faded + line-through).

---

## Wat NIET in dit ontwerp zit (bewust)

- Geen iconen voor categorieën (werk/school/etc.) — die volgen pas in v1.2
- Geen foto's of bijlages
- Geen kleur-tags
- Geen "favoriet"-ster of pin-icoon visueel
- Geen avatar of accountvermelding (privacy-first, lokaal)
- Geen kalender-prikkers of datum-pickers behalve de tijdkeuze in onboarding 4
