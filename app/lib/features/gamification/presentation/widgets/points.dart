import 'package:app/features/gamification/presentation/widgets/points_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class Points extends StatelessWidget {
  const Points({super.key, required this.points, this.alreadyEarned = false});

  final int points;
  final bool alreadyEarned;

  @override
  Widget build(final BuildContext context) => alreadyEarned
      ? PointsWidget(
          backgroundColor: DsfrColorDecisions.backgroundContrastGrey(context),
          iconColor: DsfrColorDecisions.textDefaultGrey(context),
          points: points,
        )
      : PointsWidget(points: points);
}
