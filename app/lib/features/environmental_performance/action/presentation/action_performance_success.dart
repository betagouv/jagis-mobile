import 'package:app/core/presentation/widgets/composants/question_stepper.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_state.dart';
import 'package:app/features/questions_manager/presentation/questions_manager_question_view.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class ActionPerformanceSuccess extends StatelessWidget {
  const ActionPerformanceSuccess({super.key, required this.questionManager});

  final QuestionsManagerLoadSuccess questionManager;

  @override
  Widget build(final BuildContext context) {
    final cursor = questionManager.cursor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s1v,
      children: [
        QuestionStepper(current: cursor.index + 1, total: cursor.total),
        QuestionsManagerQuestionView(key: ValueKey(cursor.element), cursor: cursor),
      ],
    );
  }
}
