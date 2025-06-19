import 'package:app/features/gamification/presentation/widgets/achievement_base.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class PointsWidget extends StatelessWidget {
  const PointsWidget({
    super.key,
    this.backgroundColor = const Color(0xFFF1F6EC),
    this.iconColor = const Color(0xFF3CD277),
    required this.points,
    this.onTap,
  });

  final Color backgroundColor;
  final Color iconColor;
  final int points;
  final VoidCallback? onTap;

  @override
  Widget build(final BuildContext context) => Semantics(
    label: Localisation.nombrePoints(points),
    child: AchievementBase(
      icon: Icon(DsfrIcons.othersLeafFill, size: DsfrSpacings.s2w, color: iconColor),
      backgroundColor: backgroundColor,
      value: points,
      onTap: onTap,
    ),
  );
}
