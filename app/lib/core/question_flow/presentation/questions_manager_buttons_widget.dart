import 'package:app/core/question_flow/bloc/question_flow_bloc.dart';
import 'package:app/core/question_flow/bloc/question_flow_event.dart';
import 'package:app/core/question_flow/domain/current_question.dart';
import 'package:app/core/question_flow/domain/cursor.dart';
import 'package:app/features/my_answers/detail/presentation/bloc/question_edit_bloc.dart';
import 'package:app/features/my_answers/detail/presentation/bloc/question_edit_state.dart';
import 'package:app/features/my_answers/detail/presentation/form/question_controller.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class QuestionsManagerButtons extends StatelessWidget {
  const QuestionsManagerButtons({super.key, required this.cursor, required this.questionController});

  final Cursor<CurrentQuestion> cursor;
  final QuestionController questionController;

  @override
  Widget build(final BuildContext context) => BlocBuilder<QuestionEditBloc, QuestionEditState>(
    builder: (final context, final state) =>
        _ButtonsContent(cursor: cursor, questionController: questionController, state: state),
  );
}

class _ButtonsContent extends StatelessWidget {
  const _ButtonsContent({required this.cursor, required this.questionController, required this.state});

  final Cursor<CurrentQuestion> cursor;
  final QuestionController questionController;
  final QuestionEditState state;

  @override
  Widget build(final BuildContext context) {
    if (state is! QuestionEditLoaded) {
      return Row(
        children: [
          if (cursor.isNotFirst)
            _PreviousButton(onPressed: () => context.read<QuestionFlowBloc>().add(const QuestionFlowPreviousRequested())),
          const SizedBox.shrink(),
        ],
      );
    }

    final loaded = state as QuestionEditLoaded;
    final isMandatory = loaded.question.isMandatory;
    final hasAnswer = loaded.answers.isNotEmpty;

    return Row(
      children: [
        if (cursor.isNotFirst)
          _PreviousButton(onPressed: () => context.read<QuestionFlowBloc>().add(const QuestionFlowPreviousRequested())),
        _ActionButton(isMandatory: isMandatory, hasAnswer: hasAnswer, questionController: questionController),
      ],
    );
  }
}

class _PreviousButton extends StatelessWidget {
  const _PreviousButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) => DsfrButton(
    icon: DsfrIcons.systemArrowLeftLine,
    iconSemanticLabel: Localisation.questionPrecedente,
    variant: DsfrButtonVariant.tertiaryWithoutBorder,
    size: DsfrComponentSize.lg,
    onPressed: onPressed,
  );
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.isMandatory, required this.hasAnswer, required this.questionController});

  final bool isMandatory;
  final bool hasAnswer;
  final QuestionController questionController;

  @override
  Widget build(final BuildContext context) {
    if (hasAnswer) {
      return DsfrButton(
        label: Localisation.questionSuivante,
        variant: DsfrButtonVariant.primary,
        size: DsfrComponentSize.lg,
        onPressed: questionController.save,
      );
    }
    if (isMandatory) {
      return const DsfrButton(
        label: Localisation.questionSuivante,
        variant: DsfrButtonVariant.primary,
        size: DsfrComponentSize.lg,
      );
    }

    return DsfrButton(
      label: Localisation.passerLaQuestion,
      variant: DsfrButtonVariant.secondary,
      size: DsfrComponentSize.lg,
      onPressed: questionController.skip,
    );
  }
}
