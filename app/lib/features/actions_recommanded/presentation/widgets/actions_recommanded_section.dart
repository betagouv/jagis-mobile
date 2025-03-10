import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/actions_recommanded/presentation/widgets/action_card.dart';
import 'package:app/features/actions_recommanded/presentation/widgets/actions_recommanded_questions.dart';
import 'package:app/features/theme/core/domain/theme_info.dart';
import 'package:app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:app/features/theme/presentation/bloc/theme_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionsRecommandedSection extends StatelessWidget {
  const ActionsRecommandedSection({super.key, required this.theme});

  final ThemeInfo theme;

  @override
  Widget build(final BuildContext context) => ColoredBox(
    color: const Color(0xFFF3EDE5),
    child: Padding(
      padding: const EdgeInsets.only(
        left: DsfrSpacings.s2w,
        top: DsfrSpacings.s4w,
        right: DsfrSpacings.s2w,
        bottom: DsfrSpacings.s6w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(Localisation.mesActionsRecommandees, style: DsfrTextStyle.headline3()),
          if (theme.isQuestionsNeeded) ...[
            const SizedBox(height: DsfrSpacings.s1w),
            const Text(Localisation.mesActionsRecommandeesDescription, style: DsfrTextStyle.bodyMd()),
          ],
          const SizedBox(height: DsfrSpacings.s3w),
          if (theme.isQuestionsNeeded) ActionsRecommandedQuestions(sequenceId: theme.sequenceId),
          if (theme.isActionsRecommandedEmpty) const _ActionsEmpty(),
          if (theme.isActionsRecommandedNotEmpty) _Actions(actions: theme.actionsRecommanded),
        ],
      ),
    ),
  );
}

class _ActionsEmpty extends StatelessWidget {
  const _ActionsEmpty();

  @override
  Widget build(final context) => Column(
    children: [
      const Placeholder(child: SizedBox(width: 133, height: 64)),
      const SizedBox(height: DsfrSpacings.s2w),
      const Text(Localisation.mesActionsRecommandeesEpuiseeTitre, style: DsfrTextStyle.headline4(), textAlign: TextAlign.center),
      const SizedBox(height: DsfrSpacings.s1v),
      const Text(
        Localisation.mesActionsRecommandeesEpuiseeDescription,
        style: DsfrTextStyle.bodyMd(),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: DsfrSpacings.s3w),
      Row(
        spacing: DsfrSpacings.s1v5,
        children: [
          DsfrLink.md(
            label: Localisation.refaire,
            icon: DsfrIcons.systemRefreshLine,
            onTap: () {
              context.read<ThemeBloc>().add(const ThemeResetRequested());
            },
          ),
          Expanded(
            child: DsfrButton(
              label: 'Explorer “Me déplacer”',
              variant: DsfrButtonVariant.primary,
              size: DsfrButtonSize.lg,
              onPressed: () {
                print('Explorer “Me déplacer”');
              },
            ),
          ),
        ],
      ),
    ],
  );
}

class _Actions extends StatefulWidget {
  const _Actions({required this.actions});

  final List<ActionSummary> actions;

  @override
  State<_Actions> createState() => _ActionsState();
}

class _ActionsState extends State<_Actions> {
  static const _initialItemsToShow = 3;
  var _showAllItems = false;

  @override
  Widget build(final BuildContext context) {
    final visibleActions = _showAllItems ? widget.actions : widget.actions.take(_initialItemsToShow).toList();

    return Column(
      spacing: DsfrSpacings.s2w,
      children: [
        ...visibleActions.map((final e) => ActionCard(action: e)),
        if (widget.actions.length > _initialItemsToShow && !_showAllItems)
          DsfrButton(
            label: Localisation.voirPlusActions,
            variant: DsfrButtonVariant.secondary,
            size: DsfrButtonSize.md,
            onPressed: () => setState(() => _showAllItems = true),
          ),
      ],
    );
  }
}
