import 'package:app/core/helpers/size.dart';
import 'package:app/features/home/bloc/home_dashboard_bloc.dart';
import 'package:app/features/home/bloc/home_dashboard_event.dart';
import 'package:app/features/home/bloc/home_dashboard_state.dart';
import 'package:app/features/home/domain/home_dashboard.dart';
import 'package:app/features/home/presentation/pages/home_page.dart';
import 'package:app/features/home/presentation/widgets/home_dashboard_counter.dart';
import 'package:app/features/home/presentation/widgets/home_recommendations.dart';
import 'package:app/features/home/presentation/widgets/home_shortcuts.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/survey/survey_section.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme_hub/presentation/helpers/tab_bar_router.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeContentLayout extends StatelessWidget {
  const HomeContentLayout({super.key});

  @override
  Widget build(final context) => BlocProvider(
    create:
        (final context) =>
            HomeDashboardBloc(repository: context.read(), recommandationsRepository: context.read())
              ..add(const HomeDashboardLoadRequested()),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => BlocBuilder<HomeDashboardBloc, HomeDashboardState>(
    builder:
        (final context, final state) => switch (state.statut) {
          HomeDashboardStateStatus.init || HomeDashboardStateStatus.loading => const Center(child: CircularProgressIndicator()),
          HomeDashboardStateStatus.failure => Center(child: Text(state.errorMessage!)),
          HomeDashboardStateStatus.success => _Success(
            homeDashboard: state.homeDashboard!,
            recommendations: state.recommendations!,
          ),
        },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.homeDashboard, required this.recommendations});

  final HomeDashboard homeDashboard;
  final List<Recommandation> recommendations;

  @override
  Widget build(final context) {
    const spacing = SizedBox(height: DsfrSpacings.s4w);
    const spacingSmall = SizedBox(height: DsfrSpacings.s2w);

    return RefreshIndicator(
      onRefresh: () async {
        if (GoRouter.of(context).canPop()) {
          GoRouter.of(context).pop();
        }
        await GoRouter.of(context).pushNamed(HomePage.name);
      },
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.white),
        child: ListView(
          padding: EdgeInsets.zero,
          clipBehavior: Clip.none,
          children: [
            HomeDashboardCounter(
              nbActionsDone: homeDashboard.nbActionsDoneUser,
              bilanCarbonePercentageCompletion: homeDashboard.environmentalImpactPercentageCompletion,
            ),
            spacingSmall,
            const _WhichDomainButtonsSection(),
            spacing,
            HomeRecommendations(recommendations),
            spacing,
            HomeShortcuts(commune: homeDashboard.communeName, nbAids: homeDashboard.nbAids, nbRecipies: homeDashboard.nbRecipies),
            spacing,

            const SurveySection(),
          ],
        ),
      ),
    );
  }
}

class _WhichDomainButtonsSection extends StatelessWidget {
  const _WhichDomainButtonsSection();

  @override
  Widget build(final BuildContext context) => Column(
    spacing: DsfrSpacings.s2w,
    children: [
      SizedBox(
        width: screenWidth(context, percentage: 0.7),
        child: const Wrap(
          children: [
            Text('Dans quel domaine souhaitez-vous agir ?', style: DsfrTextStyle.body2XlMedium(), textAlign: TextAlign.center),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
        child: GridView(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: DsfrSpacings.s1w,
            mainAxisSpacing: DsfrSpacings.s1w,
            childAspectRatio: 3,
          ),
          physics: const NeverScrollableScrollPhysics(),
          children:
              [ThemeType.alimentation, ThemeType.logement, ThemeType.transport, ThemeType.consommation]
                  .map(
                    (final theme) => DsfrButton(
                      label: theme.displayName,
                      variant: DsfrButtonVariant.primary,
                      size: DsfrButtonSize.md,
                      onPressed: () => navigateToTheme(context, theme),
                    ),
                  )
                  .toList(),
        ),
      ),
    ],
  );
}
