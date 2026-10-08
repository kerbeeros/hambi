// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:hambi_widgetbook/game/game_screens.dart'
    as _hambi_widgetbook_game_game_screens;
import 'package:hambi_widgetbook/ui_kit/action_card_view.dart'
    as _hambi_widgetbook_ui_kit_action_card_view;
import 'package:hambi_widgetbook/ui_kit/board_controls.dart'
    as _hambi_widgetbook_ui_kit_board_controls;
import 'package:hambi_widgetbook/ui_kit/camp_card_view.dart'
    as _hambi_widgetbook_ui_kit_camp_card_view;
import 'package:hambi_widgetbook/ui_kit/die_view.dart'
    as _hambi_widgetbook_ui_kit_die_view;
import 'package:hambi_widgetbook/ui_kit/forest_card_view.dart'
    as _hambi_widgetbook_ui_kit_forest_card_view;
import 'package:hambi_widgetbook/ui_kit/hambi_button.dart'
    as _hambi_widgetbook_ui_kit_hambi_button;
import 'package:hambi_widgetbook/ui_kit/hambi_icon.dart'
    as _hambi_widgetbook_ui_kit_hambi_icon;
import 'package:hambi_widgetbook/ui_kit/repression_card_view.dart'
    as _hambi_widgetbook_ui_kit_repression_card_view;
import 'package:hambi_widgetbook/ui_kit/status_chip.dart'
    as _hambi_widgetbook_ui_kit_status_chip;
import 'package:hambi_widgetbook/ui_kit/success_track.dart'
    as _hambi_widgetbook_ui_kit_success_track;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'game',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'dialogs',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'DecisionDialog',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Decisions',
                builder: _hambi_widgetbook_game_game_screens
                    .buildDecisionDialogUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'LogEntryDialog',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Log entries',
                builder: _hambi_widgetbook_game_game_screens
                    .buildLogEntryDialogUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'RoundLogSheet',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Round log',
                builder: _hambi_widgetbook_game_game_screens
                    .buildRoundLogSheetUseCase,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'view',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'GameBoard',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Board',
                builder:
                    _hambi_widgetbook_game_game_screens.buildGameBoardUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'GameResultView',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Result',
                builder: _hambi_widgetbook_game_game_screens
                    .buildGameResultViewUseCase,
              ),
            ],
          ),
        ],
      ),
    ],
  ),
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
        name: 'ActionCardView',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _hambi_widgetbook_ui_kit_action_card_view
                .buildActionCardViewUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'BoardTabs',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder:
                _hambi_widgetbook_ui_kit_board_controls.buildBoardTabsUseCase,
          ),
        ],
      ),
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
        name: 'CardSymbolView',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'All',
            builder: _hambi_widgetbook_ui_kit_action_card_view
                .buildCardSymbolViewUseCase,
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
        name: 'ForestCardView',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _hambi_widgetbook_ui_kit_forest_card_view
                .buildForestCardViewUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'HambiBottomSheet',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _hambi_widgetbook_ui_kit_board_controls
                .buildHambiBottomSheetUseCase,
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
        name: 'HambiDialog',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Decision',
            builder:
                _hambi_widgetbook_ui_kit_board_controls.buildHambiDialogUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'PhaseStepper',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _hambi_widgetbook_ui_kit_board_controls
                .buildPhaseStepperUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'RepressionCardView',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _hambi_widgetbook_ui_kit_repression_card_view
                .buildRepressionCardViewUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'RoundHeader',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder:
                _hambi_widgetbook_ui_kit_board_controls.buildRoundHeaderUseCase,
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
      _widgetbook.WidgetbookComponent(
        name: 'SuccessTrack',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder:
                _hambi_widgetbook_ui_kit_success_track.buildSuccessTrackUseCase,
          ),
        ],
      ),
    ],
  ),
];
