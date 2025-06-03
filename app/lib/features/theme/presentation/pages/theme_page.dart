import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/actions/presentation/pages/actions_page.dart';
import 'package:app/features/actions_recommanded/presentation/widgets/actions_recommanded_section.dart';
import 'package:app/features/theme/core/domain/service_item.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:app/features/theme/presentation/bloc/theme_event.dart';
import 'package:app/features/theme/presentation/bloc/theme_state.dart';
import 'package:app/features/theme/presentation/widgets/service_card.dart';
import 'package:app/features/theme/presentation/widgets/theme_header.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

final themeRouteObserver = RouteObserver<ModalRoute<dynamic>>();

class ThemePage extends StatelessWidget {
  const ThemePage({super.key, required this.themeType});

  final ThemeType themeType;

  @override
  Widget build(final BuildContext context) =>
      BlocProvider(create: (final context) => ThemeBloc(context.read(), context.read(), context.read()), child: _Page(themeType));
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
  Widget build(final BuildContext context) => BlocBuilder<ThemeBloc, ThemeState>(
    builder: (final context, final state) => switch (state) {
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

    const sizedBox = SizedBox(height: DsfrSpacings.s4w);
    const padding = EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w);

    return ListView(
      children: [
        ThemeHeader(themeType: themeType, themeSummary: data.summary),
        ActionsRecommandedSection(theme: theme),
        sizedBox,
        Padding(
          padding: padding,
          child: _Services(services: data.services),
        ),
        sizedBox,
        const Padding(padding: padding, child: _ActionCatalog()),
        const SafeArea(child: sizedBox),
      ],
    );
  }
}

class _Services extends StatelessWidget {
  const _Services({required this.services});

  final List<ServiceItem> services;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s2w,
    children: [
      const Text(Localisation.mesServices, style: DsfrTextStyle.headline4(color: DsfrColors.grey50)),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: IntrinsicHeight(
          child: Row(
            spacing: DsfrSpacings.s2w,
            children: services.map((final e) => ServiceCard(service: e)).toList(),
          ),
        ),
      ),
    ],
  );
}

class _ActionCatalog extends StatelessWidget {
  const _ActionCatalog();

  @override
  Widget build(final BuildContext context) => Column(
    spacing: DsfrSpacings.s3w,
    children: [
      const FnvImage.asset(AssetImages.actions, height: 80),
      const Text(
        Localisation.envieDeVoirOuRevoirToutesLesActions,
        style: DsfrTextStyle.headline4(color: DsfrColors.grey50),
        textAlign: TextAlign.center,
      ),
      DsfrButton(
        label: Localisation.accederAuCatalogue,
        variant: DsfrButtonVariant.secondary,
        size: DsfrComponentSize.lg,
        onPressed: () async {
          await GoRouter.of(context).pushNamed(ActionsPage.name);
        },
      ),
    ],
  );
}
