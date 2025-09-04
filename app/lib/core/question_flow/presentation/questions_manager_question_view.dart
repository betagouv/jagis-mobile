import 'package:app/core/question_flow/bloc/question_flow_bloc.dart';
import 'package:app/core/question_flow/bloc/question_flow_event.dart';
import 'package:app/core/question_flow/domain/current_question.dart';
import 'package:app/core/question_flow/domain/cursor.dart';
import 'package:app/core/question_flow/presentation/questions_manager_buttons_widget.dart';
import 'package:app/features/my_answers/detail/presentation/bloc/question_edit_bloc.dart';
import 'package:app/features/my_answers/detail/presentation/bloc/question_edit_event.dart';
import 'package:app/features/my_answers/detail/presentation/form/question_controller.dart';
import 'package:app/features/my_answers/detail/presentation/form/question_form.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class QuestionsManagerQuestionView extends StatefulWidget {
  const QuestionsManagerQuestionView({super.key, required this.cursor, this.withoutTitle = false});

  final Cursor<CurrentQuestion> cursor;
  final bool withoutTitle;

  @override
  State<QuestionsManagerQuestionView> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionsManagerQuestionView> {
  final _questionController = QuestionController();

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) =>
        QuestionEditBloc(context.read())..add(QuestionEditRecuperationDemandee(widget.cursor.element.question.code)),
    lazy: false,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: DsfrSpacings.s3w,
      children: [
        QuestionForm(
          withoutTitle: widget.withoutTitle,
          questionController: _questionController,
          onSaved: () {
            context.read<QuestionFlowBloc>().add(const QuestionFlowNextRequested());
          },
        ),
        QuestionsManagerButtons(cursor: widget.cursor, questionController: _questionController),
      ],
    ),
  );
}
