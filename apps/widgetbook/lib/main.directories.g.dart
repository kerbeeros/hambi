// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:hambi_widgetbook/ui_kit/camp_card_view.dart'
    as _hambi_widgetbook_ui_kit_camp_card_view;
import 'package:hambi_widgetbook/ui_kit/die_view.dart'
    as _hambi_widgetbook_ui_kit_die_view;
import 'package:hambi_widgetbook/ui_kit/hambi_button.dart'
    as _hambi_widgetbook_ui_kit_hambi_button;
import 'package:hambi_widgetbook/ui_kit/hambi_icon.dart'
    as _hambi_widgetbook_ui_kit_hambi_icon;
import 'package:hambi_widgetbook/ui_kit/status_chip.dart'
    as _hambi_widgetbook_ui_kit_status_chip;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'icons',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'HambiIcon',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'All',
            builder:
                _hambi_widgetbook_ui_kit_hambi_icon.buildHambiIconAllUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Single',
            builder:
                _hambi_widgetbook_ui_kit_hambi_icon.buildHambiIconSingleUseCase,
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'widgets',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'CampCardView',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _hambi_widgetbook_ui_kit_camp_card_view
                .buildCampCardViewUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'DieView',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _hambi_widgetbook_ui_kit_die_view.buildDieViewUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'HambiButton',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Primary',
            builder: _hambi_widgetbook_ui_kit_hambi_button
                .buildHambiButtonPrimaryUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Secondary',
            builder: _hambi_widgetbook_ui_kit_hambi_button
                .buildHambiButtonSecondaryUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'StatusChip',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder:
                _hambi_widgetbook_ui_kit_status_chip.buildStatusChipUseCase,
          ),
        ],
      ),
    ],
  ),
];
