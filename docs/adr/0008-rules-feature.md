# ADR 0008: Regeln als eigenes Feature `rules_presentation`

- Status: akzeptiert
- Datum: 2026-10-09

## Kontext

Der Regeln-Screen (S-05, UX-10) ist vom Start (S-01) und aus dem Spielmenü (D-10) erreichbar. Er zeigt Texte der
Anleitung, die Symbollegende und alle Karten mit dem Kartendetail (D-08) – also Kartendarstellungen und -texte, die
in `game_presentation` liegen.

## Entscheidung

- Neues **Presentation-only-Feature** `features/rules/rules_presentation` mit eigenem `RulesCubit` (aktiver Tab),
  `RulesModule`, `RulesView` und eigenen ARB-Texten (`RulesLocalizations`).
- Es hängt von `game_domain`, `game_presentation` (Kartenansichten, Symbolerklärungen, D-08) und `ui_kit` ab.
- Damit kein Zyklus entsteht, kennen `game_presentation` und `setup_presentation` die Regeln nicht: S-01 und D-10
  melden „Regeln“ per Callback (`onRules`), `hambi_app` öffnet die `RulesRoute` per `push` über dem aktuellen Screen.

## Konsequenzen

- Kartendarstellung und Texte gibt es nur einmal (in `game_presentation`); die Regeln bleiben automatisch konsistent.
- D-08 funktioniert auch ohne Spielstand (Aktionskarten auf Seite A, ohne Status).
- Alternative „Regeln in `game_presentation`“ verworfen: der Start-Screen bräuchte dann eine Abhängigkeit auf das
  ganze Spiel-Feature, und die Regeln wären nicht separat testbar.
