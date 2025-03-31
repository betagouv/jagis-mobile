// ignore_for_file: prefer-spacing

import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/bloc/action_bloc.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/gamification/presentation/widgets/points.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionScoreInstructionView extends StatelessWidget {
  const ActionScoreInstructionView({super.key, required this.action});

  final Action action;

  @override
  Widget build(final context) => FnvCard(
    child: Padding(
      padding: const EdgeInsets.all(DsfrSpacings.s2w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (action.isDone)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: DsfrSpacings.s1w,
              children: [
                Row(
                  spacing: DsfrSpacings.s1v,
                  children: [
                    const Expanded(child: Text(Localisation.actionBravo, style: DsfrTextStyle.headline3())),
                    Points(points: action.score, alreadyEarned: true),
                  ],
                ),
                Text(action.instructionWhenDone, style: const DsfrTextStyle.bodyMd()),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: DsfrSpacings.s1w,
              children: [
                const Text(Localisation.onSeLanceLeDefi, style: DsfrTextStyle.headline3()),
                switch (action) {
                  ActionClassic() => _Classic(action: action),
                  ActionSimulator() || ActionQuiz() || ActionPerformance() => Row(
                    spacing: DsfrSpacings.s1v,
                    children: [
                      Expanded(child: Text(action.instruction, style: const DsfrTextStyle.bodyMd())),
                      Points(points: action.score),
                    ],
                  ),
                },
              ],
            ),
          if (action.nbActionsDone > 1) ...[
            const SizedBox(height: DsfrSpacings.s3w),
            const DsfrDivider(),
            const SizedBox(height: DsfrSpacings.s3w),
            switch (action) {
              ActionClassic() => FnvMarkdown(data: action.scoreLabel),
              ActionSimulator() || ActionQuiz() || ActionPerformance() => FnvMarkdown(
                data: '**${action.nbActionsDone} ${action.scoreLabel}** faites par la communauté',
              ),
            },
          ],
        ],
      ),
    ),
  );
}

class _Classic extends StatelessWidget {
  const _Classic({required this.action});

  final Action action;

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(action.instruction, style: const DsfrTextStyle.bodyMd()),
      const SizedBox(height: DsfrSpacings.s3w),
      DsfrRawButton(
        variant: DsfrButtonVariant.primary,
        size: DsfrButtonSize.lg,
        onPressed: () => context.read<ActionBloc>().add(ActionMarkAsDone(id: action.id, type: action.type)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(child: Text(Localisation.jaiReleveLeDefi)),
            const SizedBox(width: DsfrSpacings.s1w),
            FnvSvg.asset(AssetImages.leaf),
            Text('+${action.score}'),
          ],
        ),
      ),
    ],
  );
}
