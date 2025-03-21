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
import 'package:app/l10n/l10n.dart';
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
      _ButtonsControllerWidget(cursor: widget.cursor, questionController: _questionController, inputController: _inputController),
    ],
  );
}

class _ButtonsControllerWidget extends StatefulWidget {
  const _ButtonsControllerWidget({required this.cursor, required this.questionController, required this.inputController});

  final Cursor<Question> cursor;
  final QuestionController questionController;
  final InputController inputController;

  @override
  State<_ButtonsControllerWidget> createState() => _ButtonsControllerWidgetState();
}

class _ButtonsControllerWidgetState extends State<_ButtonsControllerWidget> {
  var _inputIsEmpty = false;

  @override
  void initState() {
    super.initState();
    widget.inputController.addListener(_listener);
  }

  void _listener() => setState(() {
    _inputIsEmpty = widget.inputController.isEmpty;
  });

  @override
  void dispose() {
    widget.inputController.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(final context) => Row(
    children: [
      if (!widget.cursor.isStart)
        DsfrButtonIcon(
          icon: DsfrIcons.systemArrowLeftLine,
          semanticLabel: Localisation.questionPrecedente,
          variant: DsfrButtonVariant.tertiaryWithoutBorder,
          size: DsfrButtonSize.lg,
          onPressed: () => context.read<QuestionsManagerBloc>().add(const QuestionsManagerPreviousRequested()),
        ),
      if (_inputIsEmpty)
        DsfrButton(
          label: Localisation.passerLaQuestion,
          variant: DsfrButtonVariant.secondary,
          size: DsfrButtonSize.lg,
          onPressed: () => context.read<QuestionsManagerBloc>().add(const QuestionsManagerNextRequested()),
        )
      else
        DsfrButton(
          label: Localisation.questionSuivante,
          variant: DsfrButtonVariant.primary,
          size: DsfrButtonSize.lg,
          onPressed: widget.questionController.save,
        ),
    ],
  );
}
