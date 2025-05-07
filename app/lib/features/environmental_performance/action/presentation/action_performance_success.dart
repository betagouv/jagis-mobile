import 'package:app/core/presentation/widgets/composants/question_stepper.dart';
import 'package:app/core/question_flow/bloc/question_flow_state.dart';
import 'package:app/core/question_flow/presentation/questions_manager_question_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class ActionPerformanceSuccess extends StatelessWidget {
  const ActionPerformanceSuccess({super.key, required this.questionManager});

  final QuestionFlowLoadSuccess questionManager;

  @override
  Widget build(final BuildContext context) {
    final cursor = questionManager.cursor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s1v,
      children: [
        QuestionStepper(current: cursor.index, total: cursor.total),
        QuestionsManagerQuestionView(key: ValueKey(cursor.element), cursor: cursor),
      ],
    );
  }
}
