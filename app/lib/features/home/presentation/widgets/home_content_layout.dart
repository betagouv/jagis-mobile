import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/home/bloc/home_dashboard_bloc.dart';
import 'package:app/features/home/bloc/home_dashboard_event.dart';
import 'package:app/features/home/bloc/home_dashboard_state.dart';
import 'package:app/features/home/domain/home_dashboard.dart';
import 'package:app/features/home/presentation/widgets/home_action_global_counter.dart';
import 'package:app/features/home/presentation/widgets/home_dashboard_counter.dart';
import 'package:app/features/home/presentation/widgets/home_recommendations.dart';
import 'package:app/features/home/presentation/widgets/home_shortcuts.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/survey/survey_section.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/helpers/tab_bar_router.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContentLayout extends StatelessWidget {
  const HomeContentLayout({super.key});

  @override
  Widget build(final context) => BlocProvider(
    create: (final context) => HomeDashboardBloc(context.read(), context.read())..add(const HomeDashboardLoadRequested()),
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
  Widget build(final context) => RefreshIndicator(
    onRefresh: () async {
      context.read<HomeDashboardBloc>().add(const HomeDashboardLoadRequested());
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
            environmentalKgCO2e: homeDashboard.environmentalKgCO2e,
          ),
          const SizedBox(height: DsfrSpacings.s3v),
          const _WhichDomainButtonsSection(),
          const SizedBox(height: DsfrSpacings.s6w),
          HomeRecommendations(recommendations),
          const SizedBox(height: DsfrSpacings.s6w),
          HomeShortcuts(commune: homeDashboard.communeName, nbAids: homeDashboard.nbAids, nbRecipies: homeDashboard.nbRecipies),
          const SizedBox(height: DsfrSpacings.s6w),
          _HomeCounterSection(homeDashboard.nbActionsDoneNational),
          const SurveySection(),
        ],
      ),
    ),
  );
}

class _HomeCounterSection extends StatelessWidget {
  const _HomeCounterSection(this.nbActionsDoneNational);

  final int nbActionsDoneNational;

  @override
  Widget build(final BuildContext context) => Column(
    spacing: DsfrSpacings.s1w,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
        child: Row(
          spacing: DsfrSpacings.s2w,
          children: [
            HomeActionGlobalCounter(nbActionsDone: nbActionsDoneNational),
            const Expanded(
              child: Text(Localisation.actionsRealiseesEnFrance, style: DsfrTextStyle.bodyLg(color: Color(0xFF006854))),
            ),
          ],
        ),
      ),
      const FnvImage.asset(AssetImages.homeIllustration, width: double.infinity, fit: BoxFit.cover),
    ],
  );
}

class _WhichDomainButtonsSection extends StatelessWidget {
  const _WhichDomainButtonsSection();

  @override
  Widget build(final BuildContext context) => Column(
    spacing: DsfrSpacings.s3w,
    children: [
      const Text(
        Localisation.dansQuelDomaineSouhaitezVousAgir,
        style: DsfrTextStyle.body2XlMedium(),
        textAlign: TextAlign.center,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
        child: GridView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: DsfrSpacings.s1w,
            crossAxisSpacing: DsfrSpacings.s1w,
            childAspectRatio: 3,
          ),
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
