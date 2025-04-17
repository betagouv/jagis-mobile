import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/input_controller.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/question_controller.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/question_form.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_bloc.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_event.dart';
import 'package:app/features/questions_manager/domain/cursor.dart';
import 'package:app/features/questions_manager/presentation/questions_manager_buttons_widget.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionsManagerQuestionView extends StatefulWidget {
  const QuestionsManagerQuestionView({super.key, required this.cursor, this.withoutTitle = false});

  final Cursor<Question> cursor;
  final bool withoutTitle;

  @override
  State<QuestionsManagerQuestionView> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionsManagerQuestionView> {
  final _questionController = QuestionController();
  final _inputController = InputController();

  @override
  void dispose() {
    _questionController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Column(
    spacing: DsfrSpacings.s3w,
    children: [
      QuestionForm(
        questionId: widget.cursor.element!.code.value,
        withoutTitle: widget.withoutTitle,
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
