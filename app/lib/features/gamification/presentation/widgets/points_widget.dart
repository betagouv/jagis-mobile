import 'package:app/features/gamification/presentation/widgets/achievement_base.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class PointsWidget extends StatelessWidget {
  const PointsWidget({
    super.key,
    required this.points,
    this.backgroundColor = const Color(0xFFEBFCE2),
    this.iconColor = const Color(0xFF43B971),
  });

  final int points;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(final context) => Semantics(
    label: Localisation.nombrePoints(points),
    child: AchievementBase(
      value: points,
      icon: Icon(DsfrIcons.othersLeafFill, size: DsfrSpacings.s2w, color: iconColor),
      backgroundColor: backgroundColor,
    ),
  );
}
