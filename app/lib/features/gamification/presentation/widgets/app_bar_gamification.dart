import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/gamification/presentation/widgets/app_bar_badge.dart';
import 'package:app/features/gamification/presentation/widgets/points_widget.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarGamification extends StatelessWidget {
  const AppBarGamification({super.key});

  @override
  Widget build(final context) {
    final gamificationState = context.watch<GamificationBloc>().state;

    return Row(
      spacing: DsfrSpacings.s1w,
      children: [
        PointsWidget(points: gamificationState.points),
        if (gamificationState.badges > 0) AppBarBadge(value: gamificationState.badges),
      ],
    );
  }
}
