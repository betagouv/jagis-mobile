import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/input_controller.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/question_controller.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_bloc.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_event.dart';
import 'package:app/features/questions_manager/domain/cursor.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionsManagerButtons extends StatefulWidget {
  const QuestionsManagerButtons({
    super.key,
    required this.cursor,
    required this.questionController,
    required this.inputController,
  });

  final Cursor<Question> cursor;
  final QuestionController questionController;
  final InputController inputController;

  @override
  State<QuestionsManagerButtons> createState() => _QuestionsManagerButtonsState();
}

class _QuestionsManagerButtonsState extends State<QuestionsManagerButtons> {
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
