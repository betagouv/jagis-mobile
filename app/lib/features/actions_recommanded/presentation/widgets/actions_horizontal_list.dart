import 'package:app/core/helpers/size.dart';
import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/actions_recommanded/presentation/widgets/action_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class ActionsHorizontalList extends StatelessWidget {
  const ActionsHorizontalList({super.key, required this.actions});

  final List<ActionSummary> actions;

  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: EdgeInsets.zero,
    clipBehavior: Clip.none,
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: DsfrSpacings.s2w,
        children: actions
            .map(
              (final e) => SizedBox(
                width: screenWidth(context, percentage: 0.65),
                child: ActionCard(action: e),
              ),
            )
            .toList(),
      ),
    ),
  );
}
