import 'package:app/core/presentation/widgets/composants/question_stepper.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/core/domain/question_code.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/input_controller.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/question_controller.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/question_form.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_bloc.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_event.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_state.dart';
import 'package:app/features/questions_manager/domain/cursor.dart';
import 'package:app/features/questions_manager/presentation/questions_manager_buttons_widget.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionPerformanceSuccess extends StatelessWidget {
  const ActionPerformanceSuccess({super.key, required this.questionManager});

  final QuestionsManagerLoadSuccess questionManager;

  @override
  Widget build(final context) {
    final cursor = questionManager.cursor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s1v,
      children: [
        QuestionStepper(current: cursor.index + 1, total: cursor.total),
        _QuestionWidget(key: ValueKey(cursor.element), code: cursor.element!.code, cursor: cursor),
      ],
    );
  }
}

// TODO(erolley): to factorize with car_simulator ?
class _QuestionWidget extends StatefulWidget {
  const _QuestionWidget({super.key, required this.code, required this.cursor});

  final QuestionCode code;
  final Cursor<Question> cursor;

  @override
  State<_QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<_QuestionWidget> {
  final _questionController = QuestionController();
  final _inputController = InputController();

  @override
  void dispose() {
    _questionController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(final context) => Column(
    spacing: DsfrSpacings.s3w,
    children: [
      QuestionForm(
        questionId: widget.code.value,
        questionController: _questionController,
        inputController: _inputController,
        onSaved: () {
          context.read<QuestionsManagerBloc>().add(const QuestionsManagerNextRequested());
        },
      ),
      QuestionsManagerButtons(cursor: widget.cursor, questionController: _questionController, inputController: _inputController),
    ],
  );
}
