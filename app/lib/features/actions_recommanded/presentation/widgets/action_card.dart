import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/action/presentation/pages/action_page.dart';
import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/actions_recommanded/presentation/widgets/action_information.dart';
import 'package:app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:app/features/theme/presentation/bloc/theme_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({super.key, required this.action});

  final ActionSummary action;

  @override
  Widget build(final context) => DecoratedBox(
    decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: cardBoxShadow),
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
                  ActionInformation(
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
                  size: DsfrComponentSize.md,
                  onPressed: () async {
                    await GoRouter.of(context).pushNamed(
                      ActionPage.name,
                      pathParameters: ActionPage.pathParameters(type: action.type, title: action.title, id: action.id),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
