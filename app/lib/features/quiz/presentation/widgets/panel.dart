import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class Panel extends StatelessWidget {
  const Panel({
    super.key,
    this.backgroundColor = const Color(0x08000091),
    this.borderColor = const Color(0xFFE5E5F8),
    required this.child,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Widget child;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: backgroundColor,
      border: Border.all(color: borderColor),
    ),
    child: Padding(padding: const EdgeInsets.all(DsfrSpacings.s2w), child: child),
  );
}
