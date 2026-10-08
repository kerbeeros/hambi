# ADR 0004: Design im Code – Widgetbook und Golden Tests statt Figma

- Status: akzeptiert
- Datum: 2026-10-08

## Kontext

Das Design sollte ursprünglich vollständig in Figma entstehen. Die Figma-Datei läuft auf dem Starter-Plan
(max. 3 Seiten, 20 MCP-Aufrufe pro Monat); das Limit war nach Foundations, Wireframes und Basis-Komponenten erreicht.
Das Spielbrett-Layout ist entschieden (ADR 0003), Farben, Typografie, Abstände und Icons sind festgelegt.

## Entscheidung

- **Design-Quelle ist der Code**: Tokens und Bausteine in `docs/design-tokens.md`, Umsetzung in `shared/ui_kit`.
- **Widgetbook** (`widgetbook`, `widgetbook_annotation`, `widgetbook_generator`) als eigene App `apps/widgetbook`
  ersetzt die Figma-Ansicht: alle Widgets und Screens je Zustand, Smartphone und Tablet.
- **Golden Tests mit Alchemist** (`alchemist`, von VGV empfohlen) sichern jeden Zustand visuell ab; in der CI nur CI-sichere Goldens.
- Figma bleibt als Archiv (Wireframes A/B/C) bestehen und wird nicht weiter gepflegt.

## Konsequenzen

- Keine doppelte Pflege von Figma und Code; keine Kosten/Limits.
- Kein klickbarer Prototyp vor M3 – Ersatz: Widgetbook-Build und Golden-Bilder für Reviews.
- Visuelle Änderungen sind im Pull Request als Golden-Diffs sichtbar.
- Neue Pakete: `widgetbook`, `widgetbook_annotation`, `widgetbook_generator`, `alchemist` (dev).
