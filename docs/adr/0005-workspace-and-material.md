# ADR 0005: Dart Pub Workspace und `package:flutter/material.dart`

- Status: akzeptiert
- Datum: 2026-10-08

## Kontext

Das Monorepo (FFCA) braucht eine Verwaltung mehrerer Pakete. Mit Flutter 3.47 ist Material zusätzlich als eigenes
Paket `material_ui` verfügbar; `very_good create` erzeugt Apps mit `material_ui`. `material_ui` und
`package:flutter/material.dart` haben **getrennte, inkompatible Typen** (z. B. `ThemeData`).
Widgetbook 3.25 und Alchemist 0.14 verwenden `package:flutter/material.dart`.

## Entscheidung

- **Dart Pub Workspace** (Root-`pubspec.yaml` mit `workspace:`; Pakete mit `resolution: workspace`) statt Melos:
  eine gemeinsame Auflösung, ein `flutter pub get`, keine zusätzliche Abhängigkeit.
- Alle Pakete importieren **`package:flutter/material.dart`**; `material_ui` wird nicht verwendet.

## Konsequenzen

- Gemeinsame Versionsauflösung: Versionskonflikte zeigen sich sofort (z. B. `test` muss zur `test_api` von Flutter passen).
- Migration auf `material_ui`, sobald Widgetbook und Alchemist umgestellt haben (dann per `dart fix`).
