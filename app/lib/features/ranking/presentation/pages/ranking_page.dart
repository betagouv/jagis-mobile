import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/tab_indicator.dart';
import 'package:app/features/ranking/domain/ranking.dart';
import 'package:app/features/ranking/presentation/bloc/ranking_bloc.dart';
import 'package:app/features/ranking/presentation/bloc/ranking_event.dart';
import 'package:app/features/ranking/presentation/bloc/ranking_state.dart';
import 'package:app/features/ranking/presentation/widgets/badge_item.dart';
import 'package:app/features/ranking/presentation/widgets/rank_item.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
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
    final badges = successState.nationalRanking.badges;

    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (final context, final innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: DsfrSpacings.s2w),
                if (badges.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(Localisation.mesBadges, style: DsfrTextStyle.headline2(color: DsfrColors.grey50)),
                        const SizedBox(height: DsfrSpacings.s2w),
                        ...badges
                            .map((final badge) => BadgeItem(badge: badge))
                            .separator(const SizedBox(height: DsfrSpacings.s2w)),
                        const SizedBox(height: DsfrSpacings.s4w),
                      ],
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
                  child: Text(Localisation.monClassement, style: DsfrTextStyle.headline2(color: DsfrColors.grey50)),
                ),
                const SizedBox(height: DsfrSpacings.s2w),
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: FnvColors.background,
                    boxShadow: [BoxShadow(color: Color(0x08000068), offset: Offset(0, 5), blurRadius: 10)],
                  ),
                  child: TabBar(
                    tabs: [
                      Tab(text: 'à ${successState.localRanking.communeLabel ?? ''}'),
                      const Tab(text: 'en France'),
                    ],
                    indicator: const FnvTabIndicator(borderSide: BorderSide(color: DsfrColors.blueFranceSun113, width: 3)),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerHeight: 0,
                    labelStyle: const DsfrTextStyle.bodyLgBold(color: DsfrColors.blueFranceSun113),
                    labelPadding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s1w),
                    unselectedLabelStyle: const DsfrTextStyle.bodyLg(color: DsfrColors.grey50),
                  ),
                ),
              ],
            ),
          ),
        ],
        body: TabBarView(
          children: [
            _RankingList(ranking: successState.localRanking),
            _RankingList(ranking: successState.nationalRanking),
          ],
        ),
      ),
    );
  }
}

class _RankingList extends StatelessWidget {
  const _RankingList({required this.ranking});

  final Ranking ranking;

  @override
  Widget build(final BuildContext context) => ListView(
    padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
    children: [
      const SizedBox(height: DsfrSpacings.s3w),
      ...ranking.topThree
          .map((final userRank) => RankItem(userRank: userRank, isCurrentUser: userRank.id == ranking.user.id))
          .separator(const SizedBox(height: DsfrSpacings.s2w)),
      if (ranking.user.rank > 3) ...[
        const SizedBox(height: DsfrSpacings.s3w),
        const DsfrDivider(width: 113, height: 2, color: DsfrColors.blueFranceSun113, alignment: Alignment.centerLeft),
        const SizedBox(height: DsfrSpacings.s3w),
        ...ranking.userRanking
            .map((final userRank) => RankItem(userRank: userRank, isCurrentUser: userRank.id == ranking.user.id))
            .separator(const SizedBox(height: DsfrSpacings.s2w)),
      ],
    ],
  );
}
