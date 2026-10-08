import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// [RoundHeader] with editable round and phase.
@widgetbook.UseCase(name: 'Default', type: RoundHeader)
Widget buildRoundHeaderUseCase(BuildContext context) {
  return RoundHeader(
    title: context.knobs.string(label: 'Title', initialValue: 'Runde 3/12'),
    subtitle: context.knobs.string(
      label: 'Subtitle',
      initialValue: 'Vorbereitung',
    ),
    logTooltip: 'Rundenlog',
    menuTooltip: 'Spielmenü',
    onLogPressed: () {},
    onMenuPressed: () {},
  );
}

/// [PhaseStepper] with selectable active phase.
@widgetbook.UseCase(name: 'Default', type: PhaseStepper)
Widget buildPhaseStepperUseCase(BuildContext context) {
  return SizedBox(
    width: 361,
    child: PhaseStepper(
      labels: const ['Vorbereitung', 'Aktion', 'Bagger', 'Repression'],
      activeIndex: context.knobs.int.slider(label: 'Active phase', max: 3),
    ),
  );
}

/// [BoardTabs] with selectable tab and forest badge.
@widgetbook.UseCase(name: 'Default', type: BoardTabs)
Widget buildBoardTabsUseCase(BuildContext context) {
  return SizedBox(
    width: 361,
    child: BoardTabs(
      tabs: [
        BoardTab(
          label: 'Wald',
          badgeCount: context.knobs.int.slider(
            label: 'Forest badge',
            initialValue: 2,
            max: 12,
          ),
        ),
        const BoardTab(label: 'Aktionen'),
      ],
      selectedIndex: context.knobs.int.slider(label: 'Selected', max: 1),
      onSelected: (_) {},
    ),
  );
}

/// [HambiDialog] with a decision.
@widgetbook.UseCase(name: 'Decision', type: HambiDialog)
Widget buildHambiDialogUseCase(BuildContext context) {
  return HambiDialog(
    title: context.knobs.string(
      label: 'Title',
      initialValue: 'Negative Presse',
    ),
    content: const Text(
      'Ihr verliert entweder 1 Unterstützung oder 1 Mitstreiter*in.',
    ),
    actions: [
      HambiButton(label: 'Unterstützung −1', onPressed: () {}),
      HambiButton(
        label: 'Mitstreiter*in −1',
        onPressed: () {},
        style: HambiButtonStyle.secondary,
      ),
    ],
  );
}

/// [HambiBottomSheet] with plain content.
@widgetbook.UseCase(name: 'Default', type: HambiBottomSheet)
Widget buildHambiBottomSheetUseCase(BuildContext context) {
  return const HambiBottomSheet(
    title: 'Rundenlog',
    child: Text('Würfel: 3 und 5'),
  );
}
