import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/gamification/presentation/widgets/app_bar_badge.dart';
import 'package:app/features/gamification/presentation/widgets/points_widget.dart';
import 'package:app/features/ranking/presentation/pages/ranking_page.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppBarGamification extends StatelessWidget {
  const AppBarGamification({super.key});
  Future<void> _onTap(final BuildContext context) async {
    final goRouter = GoRouter.of(context);
    final currentPageName = goRouter.routerDelegate.currentConfiguration.last.route.name;
    if (currentPageName == RankingPage.name) {
      return;
    }

    await goRouter.pushNamed(RankingPage.name);
  }

  @override
  Widget build(final context) {
    final gamificationState = context.watch<GamificationBloc>().state;

    return Row(
      spacing: DsfrSpacings.s1w,
      children: [
        InkWell(onTap: () async => _onTap(context), child: PointsWidget(points: gamificationState.points)),
        if (gamificationState.badges > 0)
          InkWell(onTap: () async => _onTap(context), child: AppBarBadge(value: gamificationState.badges)),
      ],
    );
  }
}
