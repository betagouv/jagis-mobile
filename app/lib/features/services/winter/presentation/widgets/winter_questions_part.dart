import 'package:app/core/question_flow/bloc/question_flow_bloc.dart';
import 'package:app/core/question_flow/bloc/question_flow_event.dart';
import 'package:app/core/question_flow/bloc/question_flow_state.dart';
import 'package:app/core/question_flow/infrastructure/question_flow_manager.dart';
import 'package:app/core/question_flow/presentation/questions_manager_question_view.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_bloc.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_event.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class WinterQuestionsPart extends StatelessWidget {
  const WinterQuestionsPart({super.key, required this.sequenceId});

  final String sequenceId;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) =>
        QuestionFlowBloc(QuestionFlowManager(context.read(), sequenceId: sequenceId))..add(const QuestionFlowFirstRequested()),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => BlocConsumer<QuestionFlowBloc, QuestionFlowState>(
    builder: (final context, final state) => switch (state) {
      QuestionFlowInitial() || QuestionFlowFinished() => const SizedBox.shrink(),
      QuestionFlowLoadSuccess() => _LoadSuccess(state),
    },
    listener: (final context, final state) {
      if (state is QuestionFlowFinished) {
        context.read<WinterBloc>().add(const WinterQuestionsFinished());
      }
    },
  );
}

class _LoadSuccess extends StatelessWidget {
  const _LoadSuccess(this.state);

  final QuestionFlowLoadSuccess state;

  @override
  Widget build(final BuildContext context) {
    final cursor = state.cursor;
    final element = cursor.element;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s3w,
      children: [
        FnvStepper(currentStep: cursor.index, stepsCount: cursor.total, stepTitle: element.question.label),
        QuestionsManagerQuestionView(key: ValueKey(element), cursor: cursor, withoutTitle: true),
      ],
    );
  }
}
