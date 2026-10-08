# ADR 0002: Local-first, Online-Multiplayer später

- Status: akzeptiert
- Datum: 2026-10-08

## Kontext

Das MVP wird an einem Gerät gespielt (Solo / Pass & Play). Online-Multiplayer soll später möglich sein, ohne die App neu zu bauen.

## Entscheidung

- Kein Backend im MVP. Ein Spielstand wird lokal als versioniertes JSON gespeichert (Autosave nach jedem Command).
- Speicher-Paket: `shared_preferences` (vorläufig; bei Bedarf Wechsel auf Datei via `path_provider`).
- Der Spielzustand entsteht ausschließlich durch Commands; ein Command-Log ist damit die Basis für spätere Synchronisation.
- Ein späteres `game_data_online` implementiert dieselben Domain-Interfaces; Domain und Presentation bleiben unverändert.

## Konsequenzen

- Keine Accounts, keine Netzwerkabhängigkeit, kein Datenschutz-Overhead im MVP.
- Für Online müssen nur die Data-Schicht und ggf. ein Lobby-Feature ergänzt werden.
