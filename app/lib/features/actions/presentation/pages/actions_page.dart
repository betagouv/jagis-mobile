import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/core/presentation/widgets/composants/tag.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/action/presentation/pages/action_page.dart';
import 'package:app/features/actions/domain/action_filter.dart';
import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/actions/presentation/bloc/actions_bloc.dart';
import 'package:app/features/actions/presentation/bloc/actions_event.dart';
import 'package:app/features/actions/presentation/bloc/actions_state.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActionsPage extends StatelessWidget {
  const ActionsPage({super.key});

  static const name = 'actions';
  static const path = name;

  static GoRoute get route => GoRoute(path: path, name: name, builder: (final context, final state) => const ActionsPage());

  @override
  Widget build(final context) => BlocProvider(
    create: (final context) => ActionsBloc(repository: context.read())..add(const ActionsLoadRequested()),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final context) => RootPage(
    body: ListView(
      padding: const EdgeInsets.all(paddingVerticalPage),
      children: [
        const Text(Localisation.catalogueActions, style: DsfrTextStyle.headline2()),
        const SizedBox(height: DsfrSpacings.s3w),
        BlocBuilder<ActionsBloc, ActionsState>(
          builder:
              (final context, final state) => _ThemesFilter(
                activeThemes: switch (state) {
                  ActionsInitial() || ActionsLoadInProgress() || ActionsLoadFailure() => const [],
                  ActionsLoadSuccess(:final themeFilters) => themeFilters,
                },
              ),
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        BlocBuilder<ActionsBloc, ActionsState>(
          builder:
              (final context, final state) => DsfrSearchBar(
                initialValue: switch (state) {
                  ActionsInitial() || ActionsLoadInProgress() || ActionsLoadFailure() => null,
                  ActionsLoadSuccess(:final titleFilter) => titleFilter,
                },
                onChanged: (final value) {
                  context.read<ActionsBloc>().add(ActionsFilterByTitleRequested(value));
                },
              ),
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        BlocBuilder<ActionsBloc, ActionsState>(
          builder:
              (final context, final state) => DsfrToggleSwitch(
                label: Localisation.dejaConsultees,
                value: switch (state) {
                  ActionsInitial() || ActionsLoadInProgress() || ActionsLoadFailure() => false,
                  ActionsLoadSuccess(:final alreadyConsulted) => alreadyConsulted,
                },
                onChanged: (final value) => context.read<ActionsBloc>().add(ActionsFilterByConsultedRequested(value)),
              ),
        ),
        const SizedBox(height: DsfrSpacings.s3w),
        BlocBuilder<ActionsBloc, ActionsState>(
          builder:
              (final context, final state) => switch (state) {
                ActionsInitial() || ActionsLoadInProgress() => const Center(child: CircularProgressIndicator()),
                ActionsLoadSuccess() => _Success(state: state),
                ActionsLoadFailure() => const Center(child: Text('Erreur lors du chargement des actions')),
              },
        ),
      ],
    ),
  );
}

class _ThemesFilter extends StatelessWidget {
  const _ThemesFilter({required this.activeThemes});

  final List<ActionFilter> activeThemes;

  @override
  Widget build(final context) {
    const spacing = DsfrSpacings.s1w;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children:
          activeThemes
              .map(
                (final thematique) => FnvTag(
                  label: thematique.label,
                  selected: thematique.selected,
                  onTap: () => context.read<ActionsBloc>().add(ActionsFilterByThemeRequested(thematique.code)),
                ),
              )
              .toList(),
    );
  }
}

class _Success extends StatelessWidget {
  const _Success({required this.state});

  final ActionsLoadSuccess state;

  @override
  Widget build(final context) {
    final actions = state.actions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (actions.isEmpty) ...[
          const SizedBox(height: DsfrSpacings.s2w),
          FnvSvg.asset(AssetImages.bibliothequeEmpty),
          const SizedBox(height: DsfrSpacings.s3w),
          const Center(child: Text(Localisation.aucuneActionTrouvee, style: DsfrTextStyle.headline4())),
        ] else ...[
          Text(Localisation.nombreAction(actions.length), style: const DsfrTextStyle.bodyLgBold()),
          const SizedBox(height: DsfrSpacings.s2w),
          ListView.separated(
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (final context, final index) => _Element(action: actions[index]),
            separatorBuilder: (final context, final index) => const SizedBox(height: DsfrSpacings.s2w),
            itemCount: actions.length,
          ),
        ],
        const SafeArea(child: SizedBox(height: paddingVerticalPage)),
      ],
    );
  }
}

class _Element extends StatelessWidget {
  const _Element({required this.action});

  final ActionSummary action;

  @override
  Widget build(final context) {
    Future<void> onTap() async {
      await GoRouter.of(context).pushNamed(
        ActionPage.name,
        pathParameters: ActionPage.pathParameters(type: action.type, title: action.title, id: action.id),
      );
    }

    return FnvCard(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: DsfrSpacings.s2w,
          top: DsfrSpacings.s3w,
          right: DsfrSpacings.s2w,
          bottom: DsfrSpacings.s1w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FnvMarkdown(data: action.title, p: const DsfrTextStyle.bodyLg()),
            const SizedBox(height: DsfrSpacings.s1v),
            _Information(
              icon: DsfrIcons.financeMoneyEuroCircleLine,
              value: action.numberOfAidsAvailable,
              suffix: Localisation.aide,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: DsfrButtonIcon(
                icon: DsfrIcons.systemArrowRightLine,
                variant: DsfrButtonVariant.tertiaryWithoutBorder,
                size: DsfrButtonSize.md,
                onPressed: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Information extends StatelessWidget {
  const _Information({required this.icon, required this.value, required this.suffix});

  final IconData icon;
  final int value;
  final String suffix;

  @override
  Widget build(final context) =>
      value == 0
          ? const SizedBox()
          : ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 24),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: DsfrSpacings.s1w,
              children: [
                ExcludeSemantics(child: Icon(icon, size: 18, color: DsfrColors.blueFranceSun113)),
                FnvMarkdown(
                  data: '**$value** $suffix${value > 1 ? 's' : ''}',
                  p: const DsfrTextStyle.bodySmMedium(color: Color(0xff5d5d5d)),
                ),
              ],
            ),
          );
}
