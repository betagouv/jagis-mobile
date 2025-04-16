import 'package:app/features/gamification/presentation/widgets/points_widget.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class Points extends StatelessWidget {
  const Points({super.key, required this.points, this.alreadyEarned = false});

  final int points;
  final bool alreadyEarned;

  @override
  Widget build(final BuildContext context) =>
      alreadyEarned
          ? PointsWidget(
            points: points,
            backgroundColor: DsfrColors.backgroundContrastGrey,
            iconColor: DsfrColors.textDefaultGrey,
          )
          : PointsWidget(points: points);
}
