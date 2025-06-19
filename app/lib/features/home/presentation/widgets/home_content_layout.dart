import 'package:app/core/assets/images.dart';
import 'package:app/core/helpers/number_format.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/compare_gauge.dart';
import 'package:app/features/home/bloc/home_dashboard_bloc.dart';
import 'package:app/features/home/bloc/home_dashboard_event.dart';
import 'package:app/features/home/bloc/home_dashboard_state.dart';
import 'package:app/features/home/domain/home_dashboard.dart';
import 'package:app/features/home/presentation/widgets/home_action_global_counter.dart';
import 'package:app/features/home/presentation/widgets/home_recommendations.dart';
import 'package:app/features/home/presentation/widgets/home_shortcuts.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/helpers/tab_bar_router.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class HomeContentLayout extends StatelessWidget {
  const HomeContentLayout({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => HomeDashboardBloc(context.read(), context.read())..add(const HomeDashboardLoadRequested()),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => BlocBuilder<HomeDashboardBloc, HomeDashboardState>(
    builder: (final context, final state) => switch (state.statut) {
      HomeDashboardStateStatus.init || HomeDashboardStateStatus.loading => const Center(child: CircularProgressIndicator()),
      HomeDashboardStateStatus.failure => Center(child: Text(state.errorMessage!)),
      HomeDashboardStateStatus.success => _Success(homeDashboard: state.homeDashboard!, recommendations: state.recommendations!),
    },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.homeDashboard, required this.recommendations});

  final HomeDashboard homeDashboard;
  final List<Recommandation> recommendations;

  @override
  Widget build(final BuildContext context) => RefreshIndicator(
    onRefresh: () async {
      context.read<HomeDashboardBloc>().add(const HomeDashboardLoadRequested());
    },
    child: ListView(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.none,
      children: [
        _EcologicalFootprint(ecologicalFootprint: homeDashboard.ecologicalFootprint),
        const _ActionRecommendations(),
        const SizedBox(height: DsfrSpacings.s5w),
        HomeRecommendations(recommendations),
        const SizedBox(height: DsfrSpacings.s6w),
        HomeShortcuts(nbAids: homeDashboard.nbAids, nbRecipes: homeDashboard.nbRecipes),
        const SizedBox(height: DsfrSpacings.s6w),
        _HomeCounterSection(homeDashboard.nbActionsDoneNational),
      ],
    ),
  );
}

class _ActionRecommendations extends StatelessWidget {
  const _ActionRecommendations();

  @override
  Widget build(final BuildContext context) => const ColoredBox(
    color: Color(0xFFF6F4EF),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: DsfrSpacings.s3w, horizontal: DsfrSpacings.s2w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DsfrSpacings.s4w,
        children: [_ActionsWidget(), _RefineYourRecommendations()],
      ),
    ),
  );
}

class _EcologicalFootprint extends StatelessWidget {
  const _EcologicalFootprint({required this.ecologicalFootprint});

  final EcologicalFootprint ecologicalFootprint;

  @override
  Widget build(final BuildContext context) {
    final isDone = ecologicalFootprint.isDone;

    return Material(
      color: const Color(0xFF00846B),
      child: InkWell(
        onTap: () async {
          await GoRouter.of(context).pushNamed(EnvironmentalPerformanceSummaryPage.name);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3v, horizontal: DsfrSpacings.s2w),
          child: Row(
            spacing: DsfrSpacings.s1w,
            children: [
              const FnvImage.asset(AssetImages.nosGestesClimatPetit, width: 28, height: 28),
              Flexible(
                child: Row(
                  spacing: DsfrSpacings.s1w,
                  children: [
                    Flexible(
                      child: Text(
                        isDone ? 'Mon empreinte\nécologique' : 'Calculer mon\nempreinte écologique',
                        style: const DsfrTextStyle.bodyLgBold(color: Colors.white),
                      ),
                    ),
                    const Icon(DsfrIcons.systemArrowRightSLine, size: 24, color: Colors.white),
                  ],
                ),
              ),
              if (isDone)
                _CarbonDioxideEquivalentGauge(value: ecologicalFootprint.carbonDioxideEquivalent ?? 0.0)
              else
                _Progress(value: ecologicalFootprint.progressValue),
            ],
          ),
        ),
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress({required this.value});

  final int value;

  @override
  Widget build(final BuildContext context) => Stack(
    alignment: AlignmentDirectional.center,
    children: [
      SizedBox.square(
        dimension: 52,
        child: CircularProgressIndicator(
          value: value / 100,
          backgroundColor: const Color(0xFFACECAE),
          valueColor: const AlwaysStoppedAnimation(Color(0xFF69D36C)),
          strokeWidth: 4,
          strokeCap: StrokeCap.round,
        ),
      ),
      Text.rich(
        TextSpan(
          text: '$value',
          children: [
            TextSpan(
              text: '%',
              style: const DsfrTextStyle.bodySmBold(color: Colors.white).copyWith(height: 1),
            ),
          ],
        ),
        style: const DsfrTextStyle.headline3(color: Colors.white).copyWith(height: 0.6),
      ),
    ],
  );
}

class _CarbonDioxideEquivalentGauge extends StatelessWidget {
  const _CarbonDioxideEquivalentGauge({required this.value});

  final double value;

  @override
  Widget build(final BuildContext context) => Stack(
    alignment: AlignmentDirectional.topCenter,
    children: [
      CompareGauge(value: value / 12000),
      Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text.rich(
          TextSpan(
            text: FnvNumberFormat.kgToTonnes(value),
            children: [
              TextSpan(
                text: 't\n',
                style: const DsfrTextStyle.bodySmBold(color: Colors.white).copyWith(height: 0.6),
              ),
              TextSpan(
                text: 'de CO2e/an',
                style: const DsfrTextStyle.bodyXs(color: Colors.white).copyWith(height: 0.6),
              ),
            ],
          ),
          style: const DsfrTextStyle.headline2(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}

class _ActionsWidget extends StatelessWidget {
  const _ActionsWidget();

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Bonjour,', style: DsfrTextStyle.headline3(color: DsfrColorDecisions.textTitleGrey(context))),
      Text(
        'Il est temps d’agir, choisissez votre prochaine action !',
        style: DsfrTextStyle.bodyMd(color: DsfrColorDecisions.textLabelGrey(context)),
      ),
      Text('Bouton recommandées/terminées', style: DsfrTextStyle.headline3(color: DsfrColorDecisions.textTitleGrey(context))),
      Text('Listes des actions', style: DsfrTextStyle.headline3(color: DsfrColorDecisions.textTitleGrey(context))),
    ],
  );
}

class _RefineYourRecommendations extends StatelessWidget {
  const _RefineYourRecommendations();

  @override
  Widget build(final BuildContext context) => ColoredBox(
    color: const Color(0xFFE6E1D5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ColoredBox(color: Colors.red, child: SizedBox(height: 6)),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Affinez vos recommandations',
                style: DsfrTextStyle.headline6(color: DsfrColorDecisions.textTitleGrey(context)),
              ),
              const Text(
                'Répondez à plusieurs questions sur le thème de votre choix',
                style: DsfrTextStyle.bodyMd(color: Color(0xFF524525)),
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [ThemeType.alimentation, ThemeType.logement, ThemeType.transport, ThemeType.consommation]
                    .map(
                      (final theme) =>
                          DsfrLink(label: theme.displayNameWithoutEmoji, onTap: () => navigateToTheme(context, theme)),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ],
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
