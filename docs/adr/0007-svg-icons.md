# ADR 0007: Icons als SVG mit `flutter_svg`

- Status: akzeptiert
- Datum: 2026-10-08

## Kontext

`docs/design-tokens.md` definiert die Spielsymbole (Mitstreiter*in, Ressource, Secu, Unterstützung, Bäume) als SVG im Stil
des Originalmaterials. Material-Icons passen nicht zum Stil und werden in lokalen Golden Tests nicht gerendert.

## Entscheidung

- Icons werden mit **`flutter_svg`** (Flutter Favorite) aus SVG-Strings im `ui_kit` gerendert (`HambiIcon`, `HambiIconData`).
- Zusätzlich zu den Spielsymbolen enthält der Satz einfache UI-Icons (Menü, Log, Schloss, Haken) im selben Stil;
  `ui_kit`-Widgets verwenden keine Material-Icons.
- Farben der Spielsymbole sind fest (Original); UI-Icons verwenden `text/primary` bzw. `text/on-dark`.

## Konsequenzen

- Die SVGs aus `docs/design-tokens.md` werden 1:1 übernommen; neue Icons werden dort ergänzt.
- Alternative `CustomPainter` verworfen: mehr Code, schwer zu pflegen.
