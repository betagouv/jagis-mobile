import 'package:app/core/question_flow/bloc/question_flow_bloc.dart';
import 'package:app/core/question_flow/bloc/question_flow_event.dart';
import 'package:app/core/question_flow/domain/current_question.dart';
import 'package:app/core/question_flow/domain/cursor.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/input_controller.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/question_controller.dart';
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

  final Cursor<CurrentQuestion> cursor;
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
  Widget build(final BuildContext context) => Row(
    children: [
      if (widget.cursor.isNotFirst)
        DsfrButtonIcon(
          icon: DsfrIcons.systemArrowLeftLine,
          semanticLabel: Localisation.questionPrecedente,
          variant: DsfrButtonVariant.tertiaryWithoutBorder,
          size: DsfrComponentSize.lg,
          onPressed: () => context.read<QuestionFlowBloc>().add(const QuestionFlowPreviousRequested()),
        ),
      if (_inputIsEmpty)
        DsfrButton(
          label: Localisation.passerLaQuestion,
          variant: DsfrButtonVariant.secondary,
          size: DsfrComponentSize.lg,
          onPressed: () => context.read<QuestionFlowBloc>().add(const QuestionFlowNextRequested()),
        )
      else
        DsfrButton(
          label: Localisation.questionSuivante,
          variant: DsfrButtonVariant.primary,
          size: DsfrComponentSize.lg,
          onPressed: widget.questionController.save,
        ),
    ],
  );
}
