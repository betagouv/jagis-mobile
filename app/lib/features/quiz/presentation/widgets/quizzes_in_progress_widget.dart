import 'package:app/core/presentation/widgets/composants/html_widget.dart';
import 'package:app/core/presentation/widgets/composants/question_stepper.dart';
import 'package:app/features/quiz/domain/quiz.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_question/quiz_question_bloc.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_question/quiz_question_event.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_question/quiz_question_state.dart';
import 'package:app/features/quiz/presentation/bloc/quizzes/quizzes_bloc.dart';
import 'package:app/features/quiz/presentation/bloc/quizzes/quizzes_event.dart';
import 'package:app/features/quiz/presentation/bloc/quizzes/quizzes_state.dart';
import 'package:app/features/quiz/presentation/widgets/panel.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizzesInProgressWidget extends StatelessWidget {
  const QuizzesInProgressWidget({super.key, required this.inProgressState});

  final QuizzesInProgress inProgressState;

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s1v,
    children: [
      QuestionStepper(current: inProgressState.currentIndex + 1, total: inProgressState.quizzes.length),
      const SizedBox(height: DsfrSpacings.s1v),
      _Question(
        key: ValueKey('quiz_question_${inProgressState.currentIndex}'),
        quiz: inProgressState.quizzes[inProgressState.currentIndex],
        isLastQuestion: inProgressState.isLastQuestion,
      ),
    ],
  );
}

class _Question extends StatelessWidget {
  const _Question({super.key, required this.quiz, required this.isLastQuestion});

  final Quiz quiz;
  final bool isLastQuestion;

  @override
  Widget build(final context) => BlocProvider(
    create: (final context) => QuizQuestionBloc(repository: context.read(), quiz: quiz, isLastQuestion: isLastQuestion),
    child: const _QuestionView(),
  );
}

class _QuestionView extends StatelessWidget {
  const _QuestionView();

  @override
  Widget build(final context) => BlocBuilder<QuizQuestionBloc, QuizQuestionState>(
    builder:
        (final context, final state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: DsfrSpacings.s4w,
          children: [
            Text(state.quiz.question, style: const DsfrTextStyle.headline2()),
            if (state.isCorrect == null) _Form(responses: state.quiz.responses) else _Result(quizQuestionState: state),
            Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                child:
                    state.isCorrect == null
                        ? DsfrButton(
                          label: Localisation.voirLaReponse,
                          variant: DsfrButtonVariant.primary,
                          size: DsfrComponentSize.lg,
                          onPressed:
                              state.selectedResponse == null
                                  ? null
                                  : () => context.read<QuizQuestionBloc>().add(const QuizQuestionValidationRequested()),
                        )
                        : DsfrButton(
                          label: state.isLastQuestion ? Localisation.voirLeResultat : Localisation.questionSuivante,
                          variant: DsfrButtonVariant.primary,
                          size: DsfrComponentSize.lg,
                          onPressed: () => context.read<QuizzesBloc>().add(const QuizzesNextQuestion()),
                        ),
              ),
            ),
          ],
        ),
  );
}

class _Form extends StatelessWidget {
  const _Form({required this.responses});

  final List<QuizResponse> responses;

  @override
  Widget build(final context) => DsfrRadioButtonGroupHeadless(
    mode: DsfrRadioButtonSetMode.column,
    values: Map.fromEntries(responses.map((final e) => e.response).map((final e) => MapEntry(e, e))),
    onChanged: (final value) {
      if (value == null) {
        return;
      }
      context.read<QuizQuestionBloc>().add(QuizQuestionResponseSelected(value));
    },
  );
}

class _Result extends StatelessWidget {
  const _Result({required this.quizQuestionState});

  final QuizQuestionState quizQuestionState;

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: DsfrSpacings.s2w,
    children: [
      _ResultText(isCorrect: quizQuestionState.isCorrect!, response: quizQuestionState.selectedResponse!),
      _Response(quizQuestionState: quizQuestionState),
    ],
  );
}

class _ResultText extends StatelessWidget {
  const _ResultText({required this.isCorrect, required this.response});

  final bool isCorrect;
  final String response;

  @override
  Widget build(final BuildContext context) {
    final backgroundColor = isCorrect ? const Color(0xFFFAFCED) : const Color(0xFFFEF7F7);
    final borderColor = isCorrect ? const Color(0xFFCBE1AA) : const Color(0xFFFFCACA);

    return Panel(
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      child: Text.rich(
        TextSpan(
          text: Localisation.votreReponse(isCorrect),
          style: const DsfrTextStyle.bodyLg(),
          children: [TextSpan(text: response, style: const DsfrTextStyle.bodyLgBold())],
        ),
      ),
    );
  }
}

class _Response extends StatelessWidget {
  const _Response({required this.quizQuestionState});

  final QuizQuestionState quizQuestionState;

  @override
  Widget build(final context) => Panel(
    // ignore: prefer-spacing
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(Localisation.reponse, style: DsfrTextStyle.headline3()),
        const SizedBox(height: DsfrSpacings.s1v5),
        FnvHtmlWidget(quizQuestionState.explanation),
        if (quizQuestionState.quiz.sources.isNotEmpty) ...[
          const SizedBox(height: DsfrSpacings.s2w),
          // TODO(lsaudon): utiliser lien cliquable pour une liste de source
          Text('Source : ${quizQuestionState.quiz.sources.first.label}', style: const DsfrTextStyle.bodyXs()),
        ],
      ],
    ),
  );
}
