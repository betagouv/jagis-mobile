import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:flutter/material.dart';

class DsfrStepperTrack extends StatelessWidget {
  const DsfrStepperTrack({super.key, required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(final BuildContext context) =>
      CustomPaint(painter: _Painter(currentStep: current, steps: total), size: const Size(double.infinity, 8));
}

class _Painter extends CustomPainter {
  const _Painter({required this.currentStep, required this.steps});

  final int currentStep;
  final int steps;

  @override
  void paint(final Canvas canvas, final Size size) {
    const spacing = 8;
    final stepWidth = _calculateStepWidth(spacing, size);
    final trackPaint = Paint()..color = const Color(0x80C2C2C2);
    final progressPaint = Paint()..color = DsfrColors.blueFranceSun113;

    for (var i = 0; i < steps; i += 1) {
      final xPosition = i * (stepWidth + spacing);
      final isProgress = currentStep >= i + 1;
      canvas.drawRect(Rect.fromLTWH(xPosition, 0, stepWidth, size.height), isProgress ? progressPaint : trackPaint);
    }
  }

  double _calculateStepWidth(final int spacing, final Size size) => (size.width - (steps - 1) * spacing) / steps;

  @override
  bool shouldRepaint(final _Painter oldPainter) => oldPainter.currentStep != currentStep || oldPainter.steps != steps;
}
