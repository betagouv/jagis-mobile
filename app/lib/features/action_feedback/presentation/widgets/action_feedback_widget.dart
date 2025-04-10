// ignore_for_file: prefer-spacing

import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/bloc/action_bloc.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/action_feedback/presentation/pages/action_feedback_page.dart';
import 'package:app/features/action_feedback/presentation/widgets/feedback_stars.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class ActionFeedbackWidget extends StatelessWidget {
  const ActionFeedbackWidget({super.key, required this.action});

  final Action action;

  @override
  Widget build(final BuildContext context) {
    const color = Color(0xFF636774);

    return ColoredBox(
      color: DsfrColors.grey975,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s2w, horizontal: DsfrSpacings.s1w),
        child: Row(
          spacing: DsfrSpacings.s1v,
          children: [
            const Expanded(
              child: Text(Localisation.avezVousAimeCettePage, style: DsfrTextStyle.bodyMd(color: color)),
            ),
            FeedbackStars(
              size: 22,
              value: action.rate ?? 0,
              onChanged: (final value) async {
                final result = await GoRouter.of(context).pushNamed<bool>(
                  ActionFeedbackPage.name,
                  pathParameters: ActionFeedbackPage.pathParameters(
                    type: action.type,
                    title: action.title,
                    id: action.id,
                    rate: value,
                  ),
                );
                if (context.mounted && (result ?? false)) {
                  context.read<ActionBloc>().add(ActionLoadRequested(id: action.id, type: action.type));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
