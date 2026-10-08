# ADR 0001: Regel-Engine als reines Dart-Package

- Status: akzeptiert
- Datum: 2026-10-08

## Kontext

Hambi ist ein rundenbasiertes Brettspiel mit vielen Regeln und Zufallselementen (Würfel, Kartenstapel).
Die Regeln müssen per TDD vollständig testbar sein und sollen später auch serverseitig (Online-Modus) laufen können.

## Entscheidung

- Die gesamte Spiellogik liegt in `features/game/game_domain` als reines Dart-Package ohne Flutter-/IO-Abhängigkeiten.
- Die Engine ist eine reine Funktion `GameState apply(GameState, GameCommand)` auf immutablen, JSON-serialisierbaren Zuständen.
- Zufall wird ausschließlich über ein injiziertes `IRandomSource` (mit Seed) erzeugt.
- Die Darstellung erfolgt mit Flutter-Widgets, nicht mit Flame.

## Konsequenzen

- Regeln sind deterministisch und ohne UI testbar (Unit- und Simulationstests).
- Autosave, Replay und spätere Server-Ausführung nutzen denselben Code.
- Die Presentation-Schicht übersetzt nur UI-Events in Commands.
