import 'package:flutter/material.dart';

class CompareGauge extends StatelessWidget {
  const CompareGauge({super.key, required this.value});

  final double value;

  @override
  Widget build(final BuildContext context) => CustomPaint(
    painter: _Painter(value: value),
    size: const Size(60, 22),
  );
}

class _Painter extends CustomPainter {
  const _Painter({required this.value});

  final double value;

  static const _trackGradient = LinearGradient(
    colors: [Color(0xFFACECAE), Color(0xFFFFD793), Color(0xFFF97483)],
    stops: [0.0, 0.5, 1.0],
  );

  @override
  void paint(final Canvas canvas, final Size size) {
    final trackPaint = Paint()
      ..shader = _trackGradient.createShader(Offset.zero & size)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, size.height)
      ..arcToPoint(Offset(size.width, size.height), radius: Radius.circular(size.width / 1.83333333333));
    canvas.drawPath(path, trackPaint);

    final pathMetrics = path.computeMetrics().first;
    final distance = pathMetrics.length * value.clamp(0.0, 1.0);
    final tangent = pathMetrics.getTangentForOffset(distance);

    if (tangent != null) {
      final position = tangent.position;
      final angle = tangent.angle;
      final pionPath = Path()
        ..moveTo(0, 0)
        ..lineTo(3, 8)
        ..arcToPoint(const Offset(-3, 8), radius: const Radius.circular(3))
        ..close();
      final matrix = Matrix4.identity()
        ..translateByDouble(position.dx, position.dy, 0, 1)
        ..rotateZ(-angle);
      final transformedPath = pionPath.transform(matrix.storage);

      final pionPaint = Paint()
        ..color = const Color(0xFF001712)
        ..style = PaintingStyle.fill;
      canvas.drawPath(transformedPath, pionPaint);
    }
  }

  @override
  bool shouldRepaint(final _Painter oldPainter) => oldPainter.value != value;
}
