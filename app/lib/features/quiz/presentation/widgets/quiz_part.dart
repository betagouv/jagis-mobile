import 'package:app/core/presentation/widgets/composants/html_widget.dart';
import 'package:app/features/quiz/domain/quiz.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_question/quiz_question_bloc.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_question/quiz_question_event.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_question/quiz_question_state.dart';
import 'package:app/features/quiz/presentation/bloc/quizzes/quizzes_bloc.dart';
import 'package:app/features/quiz/presentation/bloc/quizzes/quizzes_event.dart';
import 'package:app/features/quiz/presentation/bloc/quizzes/quizzes_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class QuizPart extends StatelessWidget {
  const QuizPart({super.key, required this.name, required this.quizzes, required this.congratulatoryText});

  final String name;
  final List<Quiz> quizzes;
  final String congratulatoryText;

  @override
  Widget build(final context) => BlocProvider(
    create: (final context) => QuizzesBloc(quizzes: quizzes),
    child: _View(name: name, congratulatoryText: congratulatoryText),
  );
}

class _View extends StatelessWidget {
  const _View({required this.name, required this.congratulatoryText});

  final String name;
  final String congratulatoryText;

  @override
  Widget build(final context) => BlocBuilder<QuizzesBloc, QuizzesState>(
    builder:
        (final context, final state) => switch (state) {
          QuizzesInProgress() => Padding(
            padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3w, horizontal: DsfrSpacings.s2w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: DsfrSpacings.s1v,
              children: [
                _QuizStepper(index: state.currentIndex + 1, max: state.quizzes.length),
                const SizedBox(height: DsfrSpacings.s1v),
                _Question(
                  key: ValueKey('quiz_question_${state.currentIndex}'),
                  quiz: state.quizzes[state.currentIndex],
                  isLastQuestion: state.isLastQuestion,
                ),
              ],
            ),
          ),
          QuizzesCompleted() => Column(
            children: [
              Text('Vous avez terminé le quiz “$name”'),
              Text('👏 Vous avez obtenu un score de ${state.correctAnswerCount}/${state.totalQuestionsCount}'),
              Text(congratulatoryText),
              DsfrButton(
                label: 'Retourner à la thématique',
                variant: DsfrButtonVariant.primary,
                size: DsfrButtonSize.lg,
                onPressed: () => GoRouter.of(context).pop(),
              ),
              DsfrButton(
                label: 'Recommencer le quiz',
                variant: DsfrButtonVariant.secondary,
                size: DsfrButtonSize.lg,
                onPressed: () => GoRouter.of(context).pop(),
              ),
            ],
          ),
        },
  );
}

class _QuizStepper extends StatelessWidget {
  const _QuizStepper({required this.index, required this.max});

  final int index;
  final int max;

  @override
  Widget build(final context) => Text.rich(
    TextSpan(
      text: 'Question ',
      children: [TextSpan(text: '$index sur $max', style: const DsfrTextStyle.bodyMdBold(color: DsfrColors.blueFranceSun113))],
    ),
    style: const DsfrTextStyle.bodyMd(color: DsfrColors.blueFranceSun113),
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
    // ignore: avoid-long-functions
    builder: (final context, final state) {
      final quiz = state.quiz;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(quiz.question, style: const DsfrTextStyle.headline2()),
          const SizedBox(height: DsfrSpacings.s4w),
          if (state.isCorrect == null)
            DsfrRadioButtonSetHeadless(
              values: Map.fromEntries(
                quiz.responses.map((final e) => e.response).map((final e) => MapEntry(e, DsfrRadioButtonItem(e))),
              ),
              onCallback: (final value) {
                if (value == null) {
                  return;
                }
                context.read<QuizQuestionBloc>().add(QuizQuestionResponseSelected(value));
              },
              mode: DsfrRadioButtonSetMode.column,
            ),
          if (state.isCorrect != null) ...[
            Text('${state.isCorrect! ? '✅' : '❌'} Votre réponse : ${state.selectedResponse ?? ''}'),
            const SizedBox(height: DsfrSpacings.s3v),
            FnvHtmlWidget(state.explanation),
            const SizedBox(height: DsfrSpacings.s3w),
            if (quiz.sources.isNotEmpty) Text('Source : ${quiz.sources.first.label}', style: const DsfrTextStyle.bodyXs()),
          ],
          const SizedBox(height: DsfrSpacings.s4w),
          Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              child:
                  state.isCorrect == null
                      ? DsfrButton(
                        label: Localisation.voirLaReponse,
                        variant: DsfrButtonVariant.primary,
                        size: DsfrButtonSize.lg,
                        onPressed: () {
                          context.read<QuizQuestionBloc>().add(const QuizQuestionValidationRequested());
                        },
                      )
                      : DsfrButton(
                        label: state.isLastQuestion ? 'Voir le résultat' : Localisation.questionSuivante,
                        variant: DsfrButtonVariant.primary,
                        size: DsfrButtonSize.lg,
                        onPressed: () {
                          context.read<QuizzesBloc>().add(const QuizzesNextQuestion());
                        },
                      ),
            ),
          ),
        ],
      );
    },
  );
}
