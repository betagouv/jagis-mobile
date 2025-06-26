import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/features/action/presentation/pages/action_page.dart';
import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/actions_recommanded/presentation/widgets/action_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({super.key, required this.action, this.onPop});

  final ActionSummary action;
  final VoidCallback? onPop;

  @override
  Widget build(final BuildContext context) => FnvCard(
    onTap: () async {
      await GoRouter.of(context).pushNamed(
        ActionPage.name,
        pathParameters: ActionPage.pathParameters(type: action.type, title: action.title, id: action.id),
      );
      onPop?.call();
    },
    child: Padding(
      padding: const EdgeInsets.only(
        left: DsfrSpacings.s2w,
        top: DsfrSpacings.s3w,
        right: DsfrSpacings.s2w,
        bottom: DsfrSpacings.s2w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DsfrSpacings.s1w,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: DsfrSpacings.s1w,
            children: [
              FnvMarkdown(
                data: action.title,
                p: DsfrTextStyle.headline6(color: DsfrColorDecisions.textTitleGrey(context)),
              ),
              Row(
                spacing: DsfrSpacings.s1w,
                children: [
                  if (action.type != ActionType.classic) _Badge(actionType: action.type),
                  if (action.numberOfAidsAvailable > 0)
                    Flexible(
                      child: ActionInformation(
                        icon: DsfrIcons.financeMoneyEuroCircleLine,
                        value: action.numberOfAidsAvailable,
                        singular: 'aide',
                        plural: 'aides',
                      ),
                    )
                  else if (action.numberOfActionsDone > 0)
                    Flexible(
                      child: ActionInformation(
                        icon: DsfrIcons.financeMoneyEuroCircleLine,
                        value: action.numberOfActionsDone,
                        singular: 'action réalisée',
                        plural: 'actions réalisées',
                      ),
                    ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(DsfrIcons.systemArrowRightLine, size: 24, color: DsfrColorDecisions.textActionHighBlueFrance(context)),
          ),
        ],
      ),
    ),
  );
}

class _Badge extends StatelessWidget {
  const _Badge({required this.actionType});

  final ActionType actionType;

  @override
  Widget build(final BuildContext context) {
    final label = switch (actionType) {
      ActionType.quiz => 'QUIZ',
      ActionType.simulator => 'SIMULATEUR',
      ActionType.performance => 'BILAN',
      ActionType.classic => throw UnimplementedError(),
    };

    return DsfrBadge(label: label, type: DsfrBadgeType.information, size: DsfrComponentSize.sm);
  }
}
