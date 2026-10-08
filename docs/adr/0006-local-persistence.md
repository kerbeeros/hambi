# ADR 0006: Lokale Persistenz mit `shared_preferences` und versioniertem JSON

- Status: akzeptiert
- Datum: 2026-10-08

## Kontext

F-04 und T-020 verlangen genau einen automatisch gespeicherten Spielstand, der nach einem Neustart exakt
wiederhergestellt wird (AC-042). T-021 verlangt ein versioniertes JSON-Format, T-022 die Festlegung des Speicher-Pakets.
Die Regel-Engine (`game_domain`) ist reines Dart und kennt keine Serialisierung (T-006).

## Entscheidung

- **Gespeichert wird ein Snapshot des `GameState`**, nicht das Command-Log. Ein Snapshot bleibt gültig, wenn sich Regeln
  nach Klärung offener Fragen (Q1–Q20) ändern; ein Replay würde dann eine andere Partie erzeugen. Das Command-Log für den
  Online-Modus (T-010) folgt später.
- **`shared_preferences`** (`SharedPreferencesAsync`) als Speicher: ein JSON-String unter einem festen Schlüssel.
  `game_data` ist dadurch ein Flutter-Package (Abweichung von „Data = Dart“ in CLAUDE.md, bewusst: ein Package weniger
  als ein eigenes Storage-Interface).
- **DTOs mit `json_serializable`** (`json_annotation`, Codegenerierung über `build_runner`). Generierte `*.g.dart`
  werden versioniert und von Analyse und Coverage ausgenommen. Sealed-Typen (offene Entscheidung, Log-Einträge) werden
  über ein `type`-Feld unterschieden.
- **Format:** `{"schemaVersion": 1, "game": {...}}`. Unbekannte oder neuere Versionen und ungültiges JSON führen zu
  `LoadGameException` (Domain). Migrationen werden ergänzt, sobald sich das Format ändert.

## Konsequenzen

- Spielstände sind lesbar und testbar (Roundtrip über simulierte Partien).
- Jede Formatänderung erhöht `schemaVersion` und braucht eine Migration mit Test.
- Ein späteres `game_data_online` implementiert dasselbe `IGameRepository` (T-011).
