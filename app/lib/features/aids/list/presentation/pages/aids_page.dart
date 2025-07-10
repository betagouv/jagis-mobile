import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/presentation/widgets/composants/tag.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/aids/core/domain/aid_summary.dart';
import 'package:app/features/aids/core/presentation/widgets/aid_summary_card.dart';
import 'package:app/features/aids/list/presentation/bloc/aids_disclaimer/aids_disclaimer_cubit.dart';
import 'package:app/features/aids/list/presentation/bloc/aids_disclaimer/aids_disclaimer_state.dart';
import 'package:app/features/aids/list/presentation/bloc/assistance_list/aid_list_bloc.dart';
import 'package:app/features/aids/list/presentation/bloc/assistance_list/aid_list_event.dart';
import 'package:app/features/aids/list/presentation/bloc/assistance_list/aid_list_state.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class AidsPage extends StatelessWidget {
  const AidsPage({super.key});

  static const name = 'aides';
  static const path = name;

  static GoRoute get route => GoRoute(path: path, name: name, builder: (final context, final state) => const AidsPage());

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => AidListBloc(aidsRepository: context.read())..add(const AidListFetch()),
    child: const RootPage(body: _View()),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => BlocBuilder<AidListBloc, AidListState>(
    builder: (final context, final state) => switch (state) {
      AidListInitial() || AidListLoadInProgress() || AidListLoadFailure() => const SizedBox.shrink(),
      AidListLoadSuccess() => _Success(state: state),
    },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.state});

  final AidListLoadSuccess state;

  @override
  Widget build(final BuildContext context) => ListView(
    children: [
      if (!state.isCovered)
        BlocBuilder<AidsDisclaimerCubit, AidsDisclaimerState>(
          builder: (final context, final state) => switch (state) {
            AidsDisclaimerVisible() => DsfrNotice(
              titre: Localisation.leServiveNeCouvrePasEncoreVotreVille,
              description: Localisation.leServiveNeCouvrePasEncoreVotreVilleDescription,
              onClose: () => context.read<AidsDisclaimerCubit>().closeDisclaimer(),
            ),
            AidsDisclaimerNotVisible() => const SizedBox.shrink(),
          },
        ),
      SafeArea(child: _List(state: state)),
    ],
  );
}

class _List extends StatelessWidget {
  const _List({required this.state});

  final AidListLoadSuccess state;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.all(paddingVerticalPage),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FnvMarkdown(
          data: Localisation.aidListTitle,
          p: DsfrTextStyle.headline2(color: DsfrColors.grey50),
          strong: DsfrTextStyle.headline2(color: DsfrColors.blueFranceSun113),
        ),
        const SizedBox(height: DsfrSpacings.s3w),
        Wrap(
          spacing: DsfrSpacings.s1w,
          runSpacing: DsfrSpacings.s1w,
          children: [
            FnvTag(
              label: Localisation.tout,
              selected: null == state.themeSelected,
              onTap: () {
                context.read<AidListBloc>().add(const AidListThemeSelected(null));
              },
            ),
            ...ThemeType.values
                .where(state.themes.containsKey)
                .map(
                  (final e) => FnvTag(
                    label: e.displayNameWithoutEmoji,
                    selected: e == state.themeSelected,
                    onTap: () {
                      context.read<AidListBloc>().add(AidListThemeSelected(e));
                    },
                  ),
                ),
          ],
        ),
        const SizedBox(height: DsfrSpacings.s4w),
        _Elements(themes: state.currentTheme),
      ],
    ),
  );
}

class _Elements extends StatelessWidget {
  const _Elements({required this.themes});

  final Map<ThemeType, List<AidSummary>> themes;

  @override
  Widget build(final BuildContext context) {
    final entries = themes.entries;
    if (entries.length == 1) {
      final a = entries.first;

      return _ThemeSection(themeType: a.key, aids: a.value);
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (final context, final index) {
        final a = entries.elementAt(index);

        return _ThemeSection(themeType: a.key, aids: a.value);
      },
      separatorBuilder: (final context, final index) => const SizedBox(height: DsfrSpacings.s3w),
      itemCount: entries.length,
    );
  }
}

class _ThemeSection extends StatelessWidget {
  const _ThemeSection({required this.themeType, required this.aids});

  final ThemeType themeType;
  final List<AidSummary> aids;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s2w,
    children: [
      Text(
        themeType.displayName,
        style: const DsfrTextStyle.headline4(color: DsfrColors.grey50),
        semanticsLabel: themeType.displayNameWithoutEmoji,
      ),
      ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (final context, final index) => AidSummaryCard(aidSummary: aids[index]),
        separatorBuilder: (final context, final index) => const SizedBox(height: DsfrSpacings.s1w),
        itemCount: aids.length,
      ),
    ],
  );
}
