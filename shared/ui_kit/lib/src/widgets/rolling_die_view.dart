import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ui_kit/src/tokens/tokens.dart';
import 'package:ui_kit/src/widgets/die_view.dart';

/// {@template rolling_die_view}
/// An excavator die that tumbles while [rolling] and otherwise shows
/// [value] like a [DieView] (UX-04).
/// {@endtemplate}
class RollingDieView extends StatefulWidget {
  /// {@macro rolling_die_view}
  const new({
    required this.value,
    required this.rolling,
    this.semanticLabel,
    super.key,
  });

  /// Value the die shows once it stops rolling (1–6).
  final int value;

  /// Whether the die is still rolling.
  final bool rolling;

  /// Description of the result for screen readers.
  final String? semanticLabel;

  @override
  State<RollingDieView> createState() => _RollingDieViewState();
}

class _RollingDieViewState extends State<RollingDieView>
    with SingleTickerProviderStateMixin {
  // A tilt of about 11° to either side while tumbling.
  static const double _tilt = 0.2;

  late final Ticker _ticker = createTicker(_onTick);
  int _faceIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.rolling) _ticker.start();
  }

  @override
  void didUpdateWidget(RollingDieView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.rolling && !_ticker.isActive) {
      _faceIndex = 0;
      _ticker.start();
    } else if (!widget.rolling && _ticker.isActive) {
      _ticker.stop();
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    final index = elapsed.inMicroseconds ~/ AppDuration.dieFace.inMicroseconds;
    if (index != _faceIndex) setState(() => _faceIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.rolling) {
      return DieView(value: widget.value, semanticLabel: widget.semanticLabel);
    }
    // A fixed sequence keeps the animation deterministic for tests.
    final face = (widget.value + _faceIndex) % 6 + 1;
    return Transform.rotate(
      angle: _faceIndex.isEven ? -_tilt : _tilt,
      child: DieView(value: face),
    );
  }
}
