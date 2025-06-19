import 'package:flutter/material.dart';

class FnvProgressBar extends StatelessWidget {
  const FnvProgressBar({
    super.key,
    required this.height,
    required this.trackColor,
    required this.progressColor,
    required this.current,
    required this.total,
  });

  final double height;
  final Color trackColor;
  final Color progressColor;
  final int current;
  final int total;

  @override
  Widget build(final BuildContext context) => Semantics(
    label: 'Question $current sur $total',
    child: CustomPaint(
      painter: _Painter(trackColor: trackColor, progressColor: progressColor, value: current / total),
      size: Size(double.infinity, height),
    ),
  );
}

class _Painter extends CustomPainter {
  const _Painter({required this.trackColor, required this.progressColor, required this.value});

  final Color trackColor;
  final Color progressColor;
  final double value;

  @override
  void paint(final Canvas canvas, final Size size) {
    _drawTrack(canvas, size);
    _drawProgress(canvas, size);
  }

  void _drawTrack(final Canvas canvas, final Size size) {
    final track = Rect.fromLTWH(0, 0, size.width, size.height);
    final trackPaint = Paint()..color = trackColor;
    canvas.drawRect(track, trackPaint);
  }

  void _drawProgress(final Canvas canvas, final Size size) {
    final width = value.clamp(0, 1) * size.width;
    if (width <= 0.0) {
      return;
    }

    final rect = Rect.fromLTWH(0, 0, width, size.height);
    final paint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.fill;

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(final _Painter oldPainter) => oldPainter.value != value;
}
