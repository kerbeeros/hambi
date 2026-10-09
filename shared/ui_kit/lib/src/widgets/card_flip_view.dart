import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ui_kit/src/tokens/tokens.dart';

/// {@template card_flip_view}
/// A card that shows its [back] until it is [revealed] and then turns over
/// to its [front] (UX-04). It turns at once when animations are disabled.
/// {@endtemplate}
class CardFlipView extends StatefulWidget {
  /// {@macro card_flip_view}
  const new({
    required this.front,
    required this.back,
    required this.revealed,
    super.key,
  });

  /// Face of the card.
  final Widget front;

  /// Back of the card.
  final Widget back;

  /// Whether the front faces up.
  final bool revealed;

  @override
  State<CardFlipView> createState() => _CardFlipViewState();
}

class _CardFlipViewState extends State<CardFlipView>
    with SingleTickerProviderStateMixin {
  // Gives the turning card some depth.
  static const double _perspective = 0.001;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDuration.cardFlip,
    value: widget.revealed ? 1 : 0,
  );
  late final Animation<double> _turn = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  @override
  void didUpdateWidget(CardFlipView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.revealed == oldWidget.revealed) return;
    final target = widget.revealed ? 1.0 : 0.0;
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = target;
    } else {
      _controller.animateTo(target);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _turn,
      builder: (context, _) {
        final showsFront = _turn.value >= 0.5;
        // The front starts edge-on and turns the rest of the way, so it is
        // never mirrored.
        final angle = (_turn.value - (showsFront ? 1 : 0)) * math.pi;
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, _perspective)
            ..rotateY(angle),
          child: showsFront ? widget.front : widget.back,
        );
      },
    );
  }
}
