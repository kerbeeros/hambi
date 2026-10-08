# Hambi

Digitale Umsetzung des kooperativen Brettspiels **„HAMBI – Hambi bleibt!“** als Flutter-App für iOS und Android.

- Anforderungen: [`spec.md`](spec.md) · Offene Regelfragen: [`todo.md`](todo.md)
- Arbeitsweise & Konventionen: [`CLAUDE.md`](CLAUDE.md)
- Design-Tokens & Bausteine: [`docs/design-tokens.md`](docs/design-tokens.md)
- Architekturentscheidungen: [`docs/adr/`](docs/adr/) · Original-Spielmaterial: [`docs/reference/`](docs/reference/)

## Struktur (Dart Pub Workspace)

| Pfad | Inhalt |
|---|---|
| `apps/hambi_app` | App (Flavors, l10n, Routing, DI) |
| `apps/widgetbook` | Widgetbook-Katalog aller UI-Bausteine und Screens |
| `shared/ui_kit` | Design-System: Tokens, Theme, Schriften, Widgets |
| `features/game/game_domain` | Regel-Engine (reines Dart) |

## Voraussetzungen

Flutter 3.47.6 (Dart 3.13.5), `very_good_cli` (`dart pub global activate very_good_cli`).
Für iOS: Xcode; für Android: Android Studio. Widgetbook läuft in Chrome.

## Häufige Befehle

```bash
flutter pub get                                                       # alle Pakete (Workspace)
very_good test -r --coverage --test-randomize-ordering-seed random    # alle Tests
flutter analyze                                                       # statische Analyse
flutter test --tags golden --update-goldens                           # Goldens nach gewollter UI-Änderung (im Paket)
cd apps/hambi_app && flutter run --flavor development --target lib/main_development.dart
cd apps/widgetbook && dart run build_runner build -d && flutter run -d chrome
```
