import 'package:app/core/presentation/widgets/composants/failure_widget.dart';
import 'package:app/core/question/domain/question.dart';
import 'package:app/features/my_answers/detail/presentation/bloc/question_edit_bloc.dart';
import 'package:app/features/my_answers/detail/presentation/bloc/question_edit_event.dart';
import 'package:app/features/my_answers/detail/presentation/bloc/question_edit_state.dart';
import 'package:app/features/my_answers/detail/presentation/form/choix_multiple.dart';
import 'package:app/features/my_answers/detail/presentation/form/choix_unique.dart';
import 'package:app/features/my_answers/detail/presentation/form/decimal.dart';
import 'package:app/features/my_answers/detail/presentation/form/entier.dart';
import 'package:app/features/my_answers/detail/presentation/form/libre.dart';
import 'package:app/features/my_answers/detail/presentation/form/mosaic.dart';
import 'package:app/features/my_answers/detail/presentation/form/question_controller.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class QuestionForm extends StatelessWidget {
  const QuestionForm({
    super.key,
    this.withoutTitle = false,
    this.withAlreadyDoneAlert = true,
    required this.questionController,
    this.onSaved,
  });

  final bool withoutTitle;
  final bool withAlreadyDoneAlert;
  final QuestionController questionController;
  final VoidCallback? onSaved;

  @override
  Widget build(final BuildContext context) => _Content(
    withoutTitle: withoutTitle,
    withAlreadyDoneAlert: withAlreadyDoneAlert,
    questionController: questionController,
    onSaved: onSaved,
  );
}

class _Content extends StatelessWidget {
  const _Content({
    required this.withoutTitle,
    required this.withAlreadyDoneAlert,
    required this.questionController,
    required this.onSaved,
  });

  final bool withoutTitle;
  final bool withAlreadyDoneAlert;
  final QuestionController questionController;
  final VoidCallback? onSaved;

  @override
  Widget build(final BuildContext context) => BlocListener<QuestionEditBloc, QuestionEditState>(
    listener: (final context, final state) {
      final aState = state;

      if (aState is QuestionEditLoaded && aState.submissionStatus == SubmissionStatus.success) {
        onSaved?.call();
      }
    },
    listenWhen: (final previous, final current) =>
        current is QuestionEditLoaded &&
        current.submissionStatus == SubmissionStatus.success &&
        (previous is! QuestionEditLoaded || previous.submissionStatus != SubmissionStatus.success),
    child: BlocBuilder<QuestionEditBloc, QuestionEditState>(
      builder: (final context, final state) => switch (state) {
        QuestionEditInitial() => const SizedBox(height: 550),
        QuestionEditLoaded() => _LoadedContent(
          withoutTitle: withoutTitle,
          withAlreadyDoneAlert: withAlreadyDoneAlert,
          controller: questionController,
          state: state,
        ),
        QuestionEditError() => FnvFailureWidget(
          onPressed: () => context.read<QuestionEditBloc>().add(QuestionEditRecuperationDemandee(state.id)),
        ),
      },
      buildWhen: (final oldState, final newState) =>
          (oldState is! QuestionEditLoaded || newState is! QuestionEditLoaded) || oldState.question != newState.question,
    ),
  );
}

class _LoadedContent extends StatefulWidget {
  const _LoadedContent({
    required this.withoutTitle,
    required this.withAlreadyDoneAlert,
    required this.controller,
    required this.state,
  });

  final bool withoutTitle;
  final bool withAlreadyDoneAlert;
  final QuestionEditLoaded state;
  final QuestionController controller;

  @override
  State<_LoadedContent> createState() => _LoadedContentState();
}

class _LoadedContentState extends State<_LoadedContent> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);
  }

  void _listener() {
    switch (widget.controller.status) {
      case QuestionControllerStatus.save:
        context.read<QuestionEditBloc>().add(const QuestionEditMisAJourDemandee());
      case QuestionControllerStatus.skip:
        context.read<QuestionEditBloc>().add(const QuestionEditSkipRequested());
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final question = widget.state.question;
    final answers = question.answers;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s3w,
      children: [
        if (!widget.withoutTitle)
          FnvTitle(
            title: question.label,
            subtitle: switch (answers) {
              AnswersMultipleChoice() || AnswersMosaicBoolean() => Localisation.plusieursReponsesPossibles,
              AnswersSingleChoice() || AnswersInteger() || AnswersDecimal() || AnswersOpen() => null,
            },
          ),
        if (widget.withAlreadyDoneAlert && question.isAnswered) const _QuestionIsAnsweredAlert(),
        switch (answers) {
          AnswersSingleChoice() => ChoixUnique(question: answers),
          AnswersMultipleChoice() => ChoixMultiple(question: answers),
          AnswersInteger() => Entier(question: answers),
          AnswersDecimal() => Decimal(question: answers),
          AnswersOpen() => Libre(question: answers),
          AnswersMosaicBoolean() => Mosaic(question: answers),
        },
      ],
    );
  }
}

class _QuestionIsAnsweredAlert extends StatelessWidget {
  const _QuestionIsAnsweredAlert();

  @override
  Widget build(final BuildContext context) => ColoredBox(
    color: DsfrColors.blueCumulus975,
    child: Padding(
      padding: const EdgeInsets.all(DsfrSpacings.s1w),
      child: Text(
        '🧠 Nous pensons déjà connaître la réponse à cette question, mais vous pouvez la modifier',
        style: DsfrTextStyle.bodySmMedium(color: DsfrColorDecisions.backgroundFlatInfo(context)),
      ),
    ),
  );
}
