// ignore_for_file: prefer-spacing

import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/bloc/action_bloc.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/gamification/presentation/widgets/points.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionScoreInstructionView extends StatelessWidget {
  const ActionScoreInstructionView({super.key, required this.action});

  final Action action;

  @override
  Widget build(final context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s4w, horizontal: DsfrSpacings.s2w),
    child: FnvCard(
      child: Padding(
        padding: const EdgeInsets.all(DsfrSpacings.s2w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: DsfrSpacings.s2w,
          children: [
            if (action.isDone)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: DsfrSpacings.s1w,
                children: [
                  const Text('Bravo ! 🎉', style: DsfrTextStyle.headline3()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(action.instructionWhenDone, style: const DsfrTextStyle.bodyMd()),
                      Points(points: action.score, alreadyEarned: true),
                    ],
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: DsfrSpacings.s1w,
                children: [
                  const Text('On se lance le défi ?', style: DsfrTextStyle.headline3()),
                  switch (action) {
                    ActionClassic() => Column(
                      children: [
                        Text(action.instruction, style: const DsfrTextStyle.bodyMd()),
                        const SizedBox(height: DsfrSpacings.s2w),
                        // TODO(erolley): manage icons in the label
                        DsfrButton(
                          label: "J'ai relevé le défi ! +${action.score}",
                          variant: DsfrButtonVariant.primary,
                          size: DsfrButtonSize.lg,
                          onPressed: () => context.read<ActionBloc>().add(ActionMarkAsDone(action)),
                        ),
                        const SizedBox(height: DsfrSpacings.s1w),
                      ],
                    ),
                    ActionSimulator() || ActionQuiz() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(child: Text(action.instruction, style: const DsfrTextStyle.bodyMd())),
                        Points(points: action.score),
                      ],
                    ),
                  },
                ],
              ),
            const DsfrDivider(),
            if (action.nbActionsDone > 1)
              switch (action) {
                ActionClassic() => FnvMarkdown(data: action.scoreLabel, p: const DsfrTextStyle.bodyMd()),
                ActionSimulator() || ActionQuiz() => Text.rich(
                  TextSpan(
                    text: '${action.nbActionsDone} ${action.scoreLabel}',
                    style: const DsfrTextStyle.bodyMdBold(),
                    children: const [TextSpan(text: ' faites par la communautées', style: DsfrTextStyle.bodyMdItalic())],
                  ),
                ),
              }
            else
              const Text('Sois le ou la première à relever ce défi !', style: DsfrTextStyle.bodyMdItalic()),
          ],
        ),
      ),
    ),
  );
}
