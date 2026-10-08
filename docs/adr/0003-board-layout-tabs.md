# ADR 0003: Spielbrett-Layout „Tabs mit fester Statusleiste“

- Status: akzeptiert
- Datum: 2026-10-08

## Kontext

Das Spielbrett (S-03) muss 12 Waldkarten, 13 Aktionskarten, zwei Erfolgsleisten mit Repressionsfeldern, Camp, Runde/Phase
und die Primäraktion auf einem Smartphone im Hochformat darstellen. Drei Varianten wurden als Wireframe verglichen
(Figma, Seite `02 Wireframes`): A „Scroll“, B „Tabs“, C „Zoombares Brett“.

## Entscheidung

Variante **B**: feste Statusleiste (Camp, Leisten, Repression) und Tabs „Wald“ / „Aktionen“, die je Phase automatisch wechseln.
Auf dem Tablet werden die Tabs zu zwei Spalten nebeneinander.

## Begründung

- Die entscheidungsrelevanten Zahlen sind in jeder Phase sichtbar (A: scrollen weg, C: im Bottom-Sheet).
- Karten bleiben lesbar (~115 × 90 px); C ist auf dem Handy ohne Zoom unlesbar und schlechter zugänglich (NF-04).
- Klare Zuordnung Phase ↔ Tab; wenig manuelles Umschalten.
- Einfache Umsetzung mit Standard-Widgets (TabBar, Grid) und gut testbar; kein eigener Zoom/Hit-Test wie bei C.

## Konsequenzen

- Wald und Aktionen sind auf dem Handy nicht gleichzeitig sichtbar → „M → Wald“ über Dialog D-01, Badge am Tab „Wald“.
- Tablet-Layout ist eine eigene, aber einfache Anordnung derselben Widgets.
