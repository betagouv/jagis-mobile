import 'package:app/features/actions_recommanded/presentation/widgets/actions_recommanded_section.dart';
import 'package:app/features/recommandations/presentation/widgets/mes_recommandations.dart';
import 'package:app/features/theme/core/domain/service_item.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:app/features/theme/presentation/bloc/theme_event.dart';
import 'package:app/features/theme/presentation/bloc/theme_state.dart';
import 'package:app/features/theme/presentation/widgets/service_card.dart';
import 'package:app/features/theme/presentation/widgets/theme_header.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final themeRouteObserver = RouteObserver<ModalRoute<dynamic>>();

class ThemePage extends StatelessWidget {
  const ThemePage({super.key, required this.themeType});

  final ThemeType themeType;

  @override
  Widget build(final context) => BlocProvider(
    create: (final context) => ThemeBloc(themeRepository: context.read(), timedDelay: context.read()),
    child: _Page(themeType),
  );
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
  Widget build(final context) {
    final theme = data.theme;
    final themeType = theme.themeType;

    return ListView(
      children: [
        ThemeHeader(themeType: themeType, themeSummary: data.summary),
        ActionsRecommandedSection(theme: theme),
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
