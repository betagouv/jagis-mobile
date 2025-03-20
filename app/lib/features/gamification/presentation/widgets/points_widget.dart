import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class PointsWidget extends StatelessWidget {
  const PointsWidget({
    super.key,
    required this.points,
    this.backgroundColor = const Color(0xFFF1F6EC),
    this.textColor = const Color(0xFF3CD277),
  });

  final int points;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(final context) => DecoratedBox(
    decoration: BoxDecoration(color: backgroundColor, borderRadius: const BorderRadius.all(Radius.circular(DsfrSpacings.s1w))),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s1v5, horizontal: DsfrSpacings.s1w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: DsfrSpacings.s1v,
        children: [
          Text('$points', style: const DsfrTextStyle.bodySmBold(), semanticsLabel: Localisation.nombrePoints(points)),
          ExcludeSemantics(child: Icon(DsfrIcons.othersLeafFill, size: DsfrSpacings.s2w, color: textColor)),
        ],
      ),
    ),
  );
}
