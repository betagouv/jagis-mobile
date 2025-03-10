import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/features/action/presentation/pages/action_page.dart';
import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/actions_recommanded/presentation/widgets/actions_recommanded_questions.dart';
import 'package:app/features/theme/core/domain/theme_info.dart';
import 'package:app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:app/features/theme/presentation/bloc/theme_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
          const SizedBox(height: DsfrSpacings.s2w),
          if (theme.isQuestionsNeeded) ActionsRecommandedQuestions(sequenceId: theme.sequenceId),
          if (!theme.isQuestionsNeeded) _Actions(actions: theme.actionsRecommanded),
        ],
      ),
    ),
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
        ...visibleActions.map((final e) => _Element(action: e)),
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

class _Element extends StatelessWidget {
  const _Element({required this.action});

  final ActionSummary action;

  @override
  Widget build(final BuildContext context) {
    Future<void> onTap() async {
      await GoRouter.of(context).pushNamed(
        ActionPage.name,
        pathParameters: ActionPage.pathParameters(type: action.type, title: action.title, id: action.id),
      );
    }

    return FnvCard(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: DsfrSpacings.s1v,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: DsfrSpacings.s2w, top: DsfrSpacings.s2w, bottom: DsfrSpacings.s2w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: DsfrSpacings.s1v,
                  children: [
                    FnvMarkdown(data: action.title, p: const DsfrTextStyle.bodyLg()),
                    _Information(
                      icon: DsfrIcons.financeMoneyEuroCircleLine,
                      value: action.numberOfAidsAvailable,
                      suffix: Localisation.aide,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: DsfrSpacings.s1v,
              children: [
                InkWell(
                  onTap: () => context.read<ThemeBloc>().add(ThemeReplaceActionRequested(action)),
                  child: const SizedBox.square(
                    dimension: DsfrSpacings.s6w,
                    child: Icon(
                      DsfrIcons.systemRefreshLine,
                      size: 22,
                      color: DsfrColors.blueFranceSun113,
                      semanticLabel: Localisation.proposezMoiAutreChose,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: DsfrSpacings.s1w, bottom: DsfrSpacings.s1w),
                  child: DsfrButtonIcon(
                    icon: DsfrIcons.systemArrowRightLine,
                    variant: DsfrButtonVariant.primary,
                    size: DsfrButtonSize.md,
                    onPressed: onTap,
                  ),
                ),
              ],
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
  Widget build(final BuildContext context) =>
      value == 0
          ? const SizedBox()
          : ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 24),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: DsfrSpacings.s1w,
              children: [
                ExcludeSemantics(child: Icon(icon, size: 18, color: DsfrColors.blueFranceSun113)),
                Expanded(
                  child: FnvMarkdown(
                    data: '**$value** $suffix${value > 1 ? 's' : ''}',
                    p: const DsfrTextStyle.bodySmMedium(color: Color(0xff5d5d5d)),
                  ),
                ),
              ],
            ),
          );
}
