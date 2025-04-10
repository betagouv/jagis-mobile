import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class EnvironmentalPerformanceCardItemLevel extends StatelessWidget {
  const EnvironmentalPerformanceCardItemLevel({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.labelColor,
  });

  final String label;
  final Color backgroundColor;
  final Color labelColor;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(color: backgroundColor, borderRadius: const BorderRadius.all(Radius.circular(4))),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: Text(label, style: DsfrTextStyle.bodyXsMedium(color: labelColor)),
    ),
  );
}
