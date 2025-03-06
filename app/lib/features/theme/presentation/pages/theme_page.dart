import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/core/presentation/widgets/composants/badge.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/actions_recommanded/presentation/widgets/actions_recommanded_section.dart';
import 'package:app/features/challenges/section/presentation/widgets/challenges_section.dart';
import 'package:app/features/mission/mission/presentation/pages/mission_page.dart';
import 'package:app/features/recommandations/presentation/widgets/mes_recommandations.dart';
import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/domain/service_item.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:app/features/theme/presentation/bloc/theme_event.dart';
import 'package:app/features/theme/presentation/bloc/theme_state.dart';
import 'package:app/features/theme/presentation/widgets/service_card.dart';
import 'package:app/features/theme/presentation/widgets/theme_card.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final themeRouteObserver = RouteObserver<ModalRoute<dynamic>>();

class ThemePage extends StatelessWidget {
  const ThemePage({super.key, required this.themeType});

  final ThemeType themeType;

  @override
  Widget build(final context) =>
      BlocProvider(create: (final context) => ThemeBloc(themeRepository: context.read()), child: _Page(themeType));
}

class _Page extends StatefulWidget {
  const _Page(this.themeType);

  final ThemeType themeType;

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> with RouteAware {
  void _handleMission() {
    if (mounted) {
      context.read<ThemeBloc>().add(ThemeFetchRequested(widget.themeType));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeRouteObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() => _handleMission();

  @override
  void didPush() => _handleMission();

  @override
  void dispose() {
    themeRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(final context) => BlocBuilder<ThemeBloc, ThemeState>(
    builder:
        (final context, final state) => switch (state) {
          ThemeInitial() => const SizedBox.shrink(),
          ThemeLoadInProgress() => const Center(child: CircularProgressIndicator()),
          ThemeLoadSuccess() => _Success(data: state),
          ThemeLoadFailure() => const Center(child: Text('Erreur')),
        },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.data});

  final ThemeLoadSuccess data;

  @override
  Widget build(final BuildContext context) {
    final theme = data.theme;
    final themeType = theme.themeType;

    return ListView(
      children: [
        const SizedBox(height: DsfrSpacings.s4w),
        _ImageEtTitre(themeType: themeType),
        const SizedBox(height: DsfrSpacings.s4w),
        ActionsRecommandedSection(theme: theme),
        const SizedBox(height: DsfrSpacings.s4w),
        Padding(padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w), child: _Missions(missions: data.missions)),
        const SizedBox(height: DsfrSpacings.s4w),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
          child: ChallengesSection(themeType: themeType),
        ),
        const SizedBox(height: DsfrSpacings.s4w),
        Padding(padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w), child: _Services(services: data.services)),
        const SizedBox(height: DsfrSpacings.s4w),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
            child: _Recommandations(themeType: themeType),
          ),
        ),
      ],
    );
  }
}

class _ImageEtTitre extends StatelessWidget {
  const _ImageEtTitre({required this.themeType});

  final ThemeType themeType;

  @override
  Widget build(final context) => Column(
    spacing: DsfrSpacings.s1w,
    children: [
      ClipOval(
        child: SizedBox.square(
          dimension: 80,
          child: FnvSvg.asset(
            switch (themeType) {
              ThemeType.alimentation => AssetImages.alimentation,
              ThemeType.transport => AssetImages.transport,
              ThemeType.logement => AssetImages.logement,
              ThemeType.consommation => AssetImages.consommation,
              ThemeType.decouverte => throw UnimplementedError(),
            },
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Text(themeType.displayNameWithoutEmoji, style: const DsfrTextStyle.headline2()),
    ],
  );
}

class _Missions extends StatelessWidget {
  const _Missions({required this.missions});

  final List<MissionListe> missions;

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s2w,
    children: [
      const Text(Localisation.mesMissions, style: DsfrTextStyle.headline4()),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: IntrinsicHeight(
          child: Row(spacing: DsfrSpacings.s2w, children: missions.map((final e) => _Mission(mission: e)).toList()),
        ),
      ),
    ],
  );
}

class _Mission extends StatelessWidget {
  const _Mission({required this.mission});

  final MissionListe mission;

  @override
  Widget build(final context) {
    const width = 160.0;
    const color = DsfrColors.blueFranceSun113;
    const success = DsfrColors.success425;
    final progression = mission.progression / mission.progressionCible;

    return ThemeCard(
      badge:
          mission.estNouvelle
              ? const FnvBadge(label: Localisation.nouveau, backgroundColor: DsfrColors.info425)
              : progression == 1
              ? const FnvBadge(label: Localisation.termine, backgroundColor: success)
              : null,
      onTap:
          () async => GoRouter.of(
            context,
          ).pushNamed(MissionPage.name, pathParameters: {'mission': mission.code, 'thematique': mission.themeType.routeCode}),
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(DsfrSpacings.s1v)),
              child: FnvImage.network(mission.imageUrl, width: width, height: 130, fit: BoxFit.cover),
            ),
            const SizedBox(height: DsfrSpacings.s3v),
            LinearProgressIndicator(
              value: progression,
              backgroundColor: const Color(0xFFDDDDFF),
              color: progression == 1 ? success : color,
              minHeight: 7,
              semanticsLabel: '${mission.progression}/${mission.progressionCible} terminée',
              borderRadius: const BorderRadius.all(Radius.circular(DsfrSpacings.s1v)),
            ),
            const SizedBox(height: DsfrSpacings.s1w),
            Text(mission.titre, style: const DsfrTextStyle.bodyLg()),
          ],
        ),
      ),
    );
  }
}

class _Services extends StatelessWidget {
  const _Services({required this.services});

  final List<ServiceItem> services;

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s2w,
    children: [
      const Text(Localisation.mesServices, style: DsfrTextStyle.headline4()),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: IntrinsicHeight(
          child: Row(spacing: DsfrSpacings.s2w, children: services.map((final e) => ServiceCard(service: e)).toList()),
        ),
      ),
    ],
  );
}

class _Recommandations extends StatelessWidget {
  const _Recommandations({required this.themeType});

  final ThemeType themeType;

  @override
  Widget build(final context) => MesRecommandations(theme: themeType);
}
