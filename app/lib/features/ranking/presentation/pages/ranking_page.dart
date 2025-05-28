import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/ranking/presentation/bloc/ranking_bloc.dart';
import 'package:app/features/ranking/presentation/bloc/ranking_event.dart';
import 'package:app/features/ranking/presentation/bloc/ranking_state.dart';
import 'package:app/features/ranking/presentation/widgets/badge_item.dart';
import 'package:app/features/ranking/presentation/widgets/rank_item.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  static const name = 'classement';
  static const path = name;

  static GoRoute get route => GoRoute(path: path, name: name, builder: (final context, final state) => const RankingPage());

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => RankingBloc(context.read())..add(const RankingLoadRequested()),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: BlocBuilder<RankingBloc, RankingState>(
      builder: (final context, final state) => switch (state) {
        RankingInitial() || RankingLoadFailure() => const SizedBox.shrink(),
        RankingLoadInProgress() => const Center(child: CircularProgressIndicator()),
        RankingLoadSuccess() => _Success(successState: state),
      },
    ),
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.successState});

  final RankingLoadSuccess successState;

  @override
  Widget build(final BuildContext context) {
    final ranking = successState.ranking;

    final badges = ranking.badges;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(DsfrSpacings.s2w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (badges.isNotEmpty) ...[
              const Text('Mes badges', style: DsfrTextStyle.headline2()),
              const SizedBox(height: DsfrSpacings.s3w),
              ...badges.map((final badge) => BadgeItem(badge: badge)).separator(const SizedBox(height: DsfrSpacings.s2w)),
              const SizedBox(height: DsfrSpacings.s6w),
            ],
            const Text('Mon classement', style: DsfrTextStyle.headline2()),
            const SizedBox(height: DsfrSpacings.s3w),
            ...ranking.topThree
                .map((final userRank) => RankItem(userRank: userRank, isCurrentUser: userRank.id == ranking.user.id))
                .separator(const SizedBox(height: DsfrSpacings.s2w)),
            const SizedBox(height: DsfrSpacings.s4w),
            const DsfrDivider(width: 113, height: 2, color: DsfrColors.blueFranceSun113, alignment: Alignment.centerLeft),
            const SizedBox(height: DsfrSpacings.s4w),
            ...ranking.userRanking
                .map((final userRank) => RankItem(userRank: userRank, isCurrentUser: userRank.id == ranking.user.id))
                .separator(const SizedBox(height: DsfrSpacings.s2w)),
            const SafeArea(child: SizedBox(height: DsfrSpacings.s2w)),
          ],
        ),
      ),
    );
  }
}
