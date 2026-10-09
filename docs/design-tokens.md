# Design-Tokens & UI-Bausteine

> Quelle der Wahrheit für das visuelle Design. Umsetzung in `shared/ui_kit` (`AppColors`, `AppTextStyle`, `AppSpacing`, `AppRadius`, Icons, Widgets).
> Figma (https://www.figma.com/design/hkKNHto4XLTympeTQwSkTo/Hambi) ist nur noch **Archiv** (Wireframes A/B/C, erste Foundations) – siehe `docs/adr/0004-design-in-code.md`.
> Visuelle Abnahme erfolgt über **Widgetbook** (Katalog) und **Golden Tests** (Alchemist).

## 1. Farben

### 1.1 Primitive (aus den Originalgrafiken abgeleitet)

| Token | Hex | Herkunft |
|---|---|---|
| `green/tree` | `#00CC00` | Bäume, Camp-Karte |
| `green/forest-light` | `#66CC00` | Verlauf Waldkarten (hell) |
| `green/forest-dark` | `#336600` | Verlauf Waldkarten (dunkel), Spielbrett-Hintergrund |
| `green/forest-deep` | `#1F4000` | Reserve (Schatten/Hover) |
| `green/action` | `#00FF66` | Direkte Aktion (oben) |
| `green/action-light` | `#80FFAA` | Direkte Aktion (Effekt-Bereich) |
| `green/resource` | `#33E06A` | Ressourcen-Würfel |
| `yellow/campaign` | `#FFFF00` | Kampagne (oben) |
| `yellow/campaign-light` | `#FFFF80` | Kampagne (Effekt-Bereich) |
| `yellow/smiley` | `#FFD500` | Öffentliche Unterstützung |
| `blue/support` | `#66CCFF` | Support (oben) |
| `blue/support-light` | `#B3E5FF` | Support (Effekt-Bereich) |
| `blue/activist` | `#1E6BFF` | Mitstreiter*innen |
| `blue/track` | `#3399FF` | Erfolgsleiste Mitstreiter*innen |
| `brown/cleared` | `#9A6633` | abgeholzte Waldkarte |
| `brown/soil` | `#4A1A00` | entfernte Waldkarte / Erde |
| `red/repression` | `#E8231E` | Repressionsfelder, Sperren, Fehler |
| `neutral/white` | `#FFFFFF` | |
| `neutral/paper` | `#F7F3EA` | App-Hintergrund (Papier) |
| `neutral/gray-200` | `#E2E0DA` | Ränder, deaktiviert |
| `neutral/gray-500` | `#77756F` | |
| `neutral/gray-600` | `#6B6963` | Sekundärtext (WCAG AA auf `bg/app`, NF-04) |
| `neutral/gray-900` | `#222222` | Secu |
| `neutral/black` | `#111111` | Primärtext, Ränder |

### 1.2 Semantisch (`AppColors`)

Widgets verwenden **nur** semantische Tokens. Nur ein Modus (hell); Dark Mode ist kein MVP-Ziel.

| Token | → Primitive | Verwendung |
|---|---|---|
| `bg/app` | `neutral/paper` | Scaffold-Hintergrund |
| `bg/surface` | `neutral/white` | Karten, Sheets, Dialoge |
| `bg/board` | `green/forest-dark` | Header, Wald-Bereich |
| `text/primary` | `neutral/black` | Text |
| `text/secondary` | `neutral/gray-600` | Hilfstext |
| `text/on-dark` | `neutral/white` | Text auf `bg/board` |
| `border/default` | `neutral/black` | starke Ränder, belegte Karte |
| `border/subtle` | `neutral/gray-200` | normale Ränder |
| `forest/intact` | `green/tree` | Waldkarte „wald“ |
| `forest/cleared` | `brown/cleared` | Waldkarte „abgeholzt“ |
| `forest/removed` | `brown/soil` | Waldkarte „entfernt“ |
| `card/direct-action` / `-effect` | `green/action` / `green/action-light` | Direkte Aktionen |
| `card/campaign` / `-effect` | `yellow/campaign` / `yellow/campaign-light` | Kampagnen |
| `card/support` / `-effect` | `blue/support` / `blue/support-light` | Support |
| `card/camp` | `green/tree` | Camp |
| `card/repression` | `neutral/white` | Repressionskarten |
| `token/activist` | `blue/activist` | Mitstreiter*in-Marker |
| `token/resource` | `green/resource` | Ressourcen-Marker |
| `token/secu` | `neutral/gray-900` | Secu-Marker |
| `track/activists` | `blue/track` | gefüllte Felder M-Leiste |
| `track/support` | `yellow/smiley` | gefüllte Felder U-Leiste |
| `track/repression-field` | `red/repression` | Markierung Repressionsfeld |
| `state/blocked` | `red/repression` | gesperrte Karte, Bagger-Ziel |
| `state/disabled` | `neutral/gray-200` | leere Leistenfelder, deaktiviert |
| `action/primary` | `green/forest-dark` | Primärbutton |
| `action/on-primary` | `neutral/white` | Text auf Primärbutton |

Kontrast: Text immer `text/primary` auf den hellen Kartenfarben (Gelb/Grün/Blau); `text/on-dark` nur auf `bg/board` / `action/primary`. Zustände nie nur über Farbe (zusätzlich Badge/Icon/Text, NF-04).

## 2. Typografie (`AppTextStyle`)

Schriften: **Special Elite** (Überschriften, Kartentitel – Schreibmaschine wie das Original) und **Nunito** (Text, Zahlen). Lizenzen: Nunito SIL OFL 1.1, Special Elite Apache 2.0 (Lizenztexte in `shared/ui_kit/assets/fonts/`). Als Assets im `ui_kit` gebündelt (kein Laden zur Laufzeit).

| Stil | Schrift | Gewicht | Größe / Zeilenhöhe |
|---|---|---|---|
| `display` | Special Elite | Regular | 32 / 40 |
| `headingH1` | Special Elite | Regular | 24 / 32 |
| `headingH2` | Special Elite | Regular | 20 / 28 |
| `cardTitle` | Special Elite | Regular | 13 / 16 |
| `bodyDefault` | Nunito | Regular | 16 / 24 |
| `bodySmall` | Nunito | Regular | 14 / 20 |
| `label` | Nunito | Bold | 14 / 20 |
| `caption` | Nunito | SemiBold | 12 / 16 |
| `numberLarge` | Nunito | ExtraBold | 20 / 24 |
| `numberSmall` | Nunito | ExtraBold | 14 / 16 |

Alle Stile skalieren mit der System-Schriftgröße (`MediaQuery.textScaler`).

## 3. Abstände & Radien (`AppSpacing`, `AppRadius`)

| Abstand | Wert | | Radius | Wert |
|---|---|---|---|---|
| `xxs` | 2 | | `sm` | 4 |
| `xs` | 4 | | `md` | 8 |
| `sm` | 8 | | `lg` | 12 |
| `md` | 12 | | `xl` | 16 |
| `lg` | 16 | | `full` | 999 |
| `xl` | 24 | | | |
| `xxl` | 32 | | | |
| `xxxl` | 48 | | | |

Touch-Ziele mindestens 48 × 48 dp (Android) bzw. 44 × 44 pt (iOS), NF-04. Bildschirmrand Smartphone: `lg` (16).

### 3.1 Bewegung (`AppDuration`)

| Token | Wert | Verwendung |
|---|---|---|
| `dieFace` | 80 ms | Wechsel der Augenzahl eines rollenden Würfels |
| `cardFlip` | 400 ms | Umdrehen einer Karte (Kurve `easeInOut`) |
| `reveal` | 1000 ms | Würfel rollen bzw. Karte liegt verdeckt, bevor das Ergebnis erscheint (UX-04) |

Animationen sind überspringbar (UX-04) und entfallen bei „Bewegung reduzieren“ (`MediaQuery.disableAnimations`).

## 4. Icons

24 × 24 Vektor-Icons im Stil des Spielmaterials, gerendert mit `flutter_svg` (ADR 0007) als `HambiIcon(HambiIconData.x)`. Farben der Spielsymbole sind fest (entsprechen dem Original) und werden nicht umgefärbt. `ui_kit`-Widgets verwenden keine Material-Icons.

Zusätzlich zu den Spielsymbolen unten gibt es UI-Icons im selben Stil (Quelltext in `shared/ui_kit/lib/src/icons/hambi_icon_data.dart`): `die` (Würfel), `arrow` (→), `reroll` (↻), `oneTime` (⦸, einmalige Repressionskarte), `menu`, `log`, `lock` (blockiert), `check` (belegt). UI-Icons dürfen per `color` eingefärbt werden (z. B. `text/on-dark` im Header).

| Icon | SVG |
|---|---|
| Mitstreiter*in | `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5 6v12c0 1.7 3.1 3 7 3s7-1.3 7-3V6" fill="#1E6BFF" stroke="#0A2E80" stroke-width="1.5"/><ellipse cx="12" cy="6" rx="7" ry="3" fill="#6FA0FF" stroke="#0A2E80" stroke-width="1.5"/></svg>` |
| Ressource | `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4 8l8-4 8 4-8 4-8-4z" fill="#8CF5A8" stroke="#0E6B2C" stroke-width="1.5" stroke-linejoin="round"/><path d="M4 8v8l8 4v-8L4 8z" fill="#33E06A" stroke="#0E6B2C" stroke-width="1.5" stroke-linejoin="round"/><path d="M20 8v8l-8 4v-8l8-4z" fill="#22B553" stroke="#0E6B2C" stroke-width="1.5" stroke-linejoin="round"/></svg>` |
| Secu | `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5 6v12c0 1.7 3.1 3 7 3s7-1.3 7-3V6" fill="#222222" stroke="#000000" stroke-width="1.5"/><ellipse cx="12" cy="6" rx="7" ry="3" fill="#555555" stroke="#000000" stroke-width="1.5"/></svg>` |
| Unterstützung | `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="12" cy="12" r="10" fill="#FFD500" stroke="#7A5C00" stroke-width="1.5"/><circle cx="8.5" cy="10" r="1.4" fill="#111111"/><circle cx="15.5" cy="10" r="1.4" fill="#111111"/><path d="M7.5 14.5c1.2 1.8 2.7 2.6 4.5 2.6s3.3-.8 4.5-2.6" stroke="#111111" stroke-width="1.6" stroke-linecap="round"/></svg>` |
| Laubbaum | `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><rect x="10.5" y="14" width="3" height="8" rx="1" fill="#5A1E00"/><circle cx="12" cy="9.5" r="7" fill="#008A00" stroke="#004D00" stroke-width="1.5"/><circle cx="12" cy="9.5" r="3" fill="#33DD33"/></svg>` |
| Tanne | `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><rect x="10.5" y="17" width="3" height="5" rx="1" fill="#5A1E00"/><path d="M12 2L4 18h16L12 2z" fill="#006B2E" stroke="#003D18" stroke-width="1.5" stroke-linejoin="round"/><path d="M12 8l-3.5 7h7L12 8z" fill="#00B04A"/></svg>` |
| Baumstumpf | `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7 11v8c0 1.1 2.2 2 5 2s5-.9 5-2v-8" fill="#6B3A12" stroke="#3A1A00" stroke-width="1.5"/><ellipse cx="12" cy="11" rx="5" ry="2" fill="#D9A066" stroke="#3A1A00" stroke-width="1.5"/></svg>` |

### 4.1 Originalgrafiken

Assets in `shared/ui_kit/assets/images/`, extrahiert aus den Original-PDFs (`docs/reference/`) mit poppler (`pdftocairo`):

| Asset | Quelle | Format | Einsatz |
|---|---|---|---|
| `logo.png` (+ `2.0x/`, `3.0x/`) | Anleitung S. 2, Ausschnitt x 426, y 190, 394 × 98 pt | PNG mit Transparenz, Basisbreite 280 dp (der Baum ist im Original eine Rastergrafik) | `HambiLogo` auf S-01 |
| `forest/forest_intact_00–11.svg` | Spielplan S. 1 (Vorderseiten) | SVG, eine Karte je Datei (133 × 205 pt, Hintergrundverlauf inklusive) | `ForestCardView` „wald“ |
| `forest/forest_cleared_00–11.svg` | Spielplan S. 2 (Rückseiten, spiegelverkehrt gedruckt: Rückseite von Spalte *c* steht in Spalte 3 − *c*) | SVG wie oben | `ForestCardView` „abgeholzt“ |

Motiv-Nummer = 4 × Waldspalte + Position (beide ab 0), also Zeile × 4 + Spalte im Spielplan. Die Karten werden mit `BoxFit.cover` auf 78 × 104 gesetzt, oben und unten wird dabei etwas abgeschnitten.
Extraktion Waldkarten: `pdftocairo -svg` pro Seite, dann je Karte die Pfade im Kartenrahmen behalten, leere Pfade (`M x y Z`, Schnittmarken – Flutter zeichnet sie als Punkte) entfernen, Farben in Hex umrechnen und Zahlen auf 2 Nachkommastellen runden.
Extraktion Logo: `pdftoppm -gray` mit dem Ausschnitt oben, dann Helligkeit in Transparenz umrechnen (schwarz mit Alpha = 255 − Grauwert), weil die Seite einen weißen Hintergrund zeichnet.
Nicht übernommen: Sanduhr „System Change not Climate Change“, Würfel- und Zeltzeichnung (Raster, in der Spec nicht vorgesehen; Würfel/Camp bleiben Icons).

## 5. Komponenten (`ui_kit`)

Jede Komponente ist ein eigenes Widget, hat einen Widgetbook-Use-Case pro Zustand und einen Alchemist-Golden-Test.
Karten-Widgets tragen das Suffix `View` (z. B. `ForestCardView`), um Namenskonflikte mit den Domain-Models (`ForestCard`) zu vermeiden. Texte werden immer als Parameter übergeben; das `ui_kit` kennt keine Lokalisierung.

| Widget | Zustände / Parameter | Maße (Smartphone) |
|---|---|---|
| `HambiButton` | primary / secondary × enabled / disabled, Label | Höhe 48, Radius `lg` |
| `StatusChip` | activist / resource / support / repression, Label | Höhe 28, Radius `full` |
| `ForestCardView` | intact / cleared / removed × none / activist / secu × target (roter Rand + „!“-Badge); `motif` 0–11 wählt das Original-Motiv (§4.1) | 78 × 104, Radius `card` |
| `ActionCardView` | directAction / campaign / support × available / assigned (✓) / blocked (Schloss) / unavailable (abgeblendet); Titel, Bedingungen und Effekte als `CardSymbol`, Seite, Status-Text | 113 × 96, Radius `card`; oben Kartenfarbe (Bedingung), unten Effektfarbe |
| `CardSymbolView` | activist, resource, ±support, +activist, +resource, activist→forest, reroll, −repression | Icons 14 (Karte) bzw. 18 |
| `CampCardView` | Anzahl M, Anzahl R | 113 × 96 |
| `RepressionCardView` | immediate / blocking (dicker Rahmen) / oneTime (⦸); Titel, Text; kompakt fürs Brett | Dialog 200 × 280, kompakt 113 × 56 |
| `SuccessTrack` | activists / support; Wert 0–11; Repressionsfelder (roter Rand), aktivierte Felder (Repressions-Symbol) | Zellen 22 (kompakt) bzw. 26 |
| `DieView` | Wert 1–6 | 40 × 40, Radius `md` |
| `RollingDieView` | Wert 1–6 × rollend (wechselnde Augen, leicht gedreht) / liegend (= `DieView`) | wie `DieView` |
| `RepressionCardBackView` | Rückseite einer Repressionskarte (Repressions-Symbol) | 200 × 280 |
| `CardFlipView` | Vorder-/Rückseite × aufgedeckt / verdeckt; dreht beim Aufdecken um die Hochachse (`cardFlip`) | Größe der Karte |
| `RoundHeader` | Runde, Phase, Buttons Log/Menü | Höhe ≈ 64, `bg/board` |
| `PhaseStepper` | aktive Phase 1–4 | |
| `BoardTabs` | Wald / Aktionen, Badge | Segmented Control, Höhe 52 (Segmente 48) |
| `HambiLogo` | Original-Logo (§4.1), `semanticLabel` | Breite 280 (skaliert mit `width`) |
| `HambiDialog`, `HambiBottomSheet` | Titel, Inhalt, Aktionen; Dialoge nicht durch Tippen daneben schließbar (UX-03) | |

## 6. Layout „Spielbrett“ (Variante B, ADR 0003)

Smartphone (Referenz 393 × 852):

```
┌───────────────────────────────┐
│ RoundHeader (Runde x/12, Phase) │  bg/board
├───────────────────────────────┤
│ StatusChips: M frei · R · Repr. │  bg/app, fest
│ SuccessTrack M (kompakt)        │
│ SuccessTrack U (kompakt)        │
├───────────────────────────────┤
│ BoardTabs [Wald • | Aktionen]   │
├───────────────────────────────┤
│ Tab-Inhalt (scrollt)            │
│  Wald: 3 Waldspalten × 4 Karten │
│  Aktionen: Gruppen 3-spaltig    │
├───────────────────────────────┤
│ Primäraktion (fixiert)          │  bg/surface
└───────────────────────────────┘
```

Tablet: Statusbereich oben über volle Breite, darunter Wald (links) und Aktionsplan (rechts) nebeneinander, Primäraktion unten rechts.
