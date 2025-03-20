import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/gamification/presentation/widgets/points_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalPoints extends StatelessWidget {
  const GlobalPoints({super.key});

  @override
  Widget build(final context) {
    final points = context.select<GamificationBloc, int>((final value) => value.state.points);

    return PointsWidget(points: points);
  }
}
