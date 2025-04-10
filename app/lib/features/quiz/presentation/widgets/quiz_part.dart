import 'package:app/features/action/presentation/bloc/action_bloc.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/quiz/domain/quiz.dart';
import 'package:app/features/quiz/presentation/bloc/quizzes/quizzes_bloc.dart';
import 'package:app/features/quiz/presentation/bloc/quizzes/quizzes_state.dart';
import 'package:app/features/quiz/presentation/widgets/quizzes_completed_widget.dart';
import 'package:app/features/quiz/presentation/widgets/quizzes_in_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class QuizPart extends StatelessWidget {
  const QuizPart({super.key, required this.id, required this.name, required this.quizzes, required this.congratulatoryText});

  final String id;
  final String name;
  final List<Quiz> quizzes;
  final String congratulatoryText;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => QuizzesBloc(repository: context.read(), quizzes: quizzes, id: id),
    child: _View(id: id, name: name, congratulatoryText: congratulatoryText),
  );
}

class _View extends StatelessWidget {
  const _View({required this.id, required this.name, required this.congratulatoryText});

  final String id;
  final String name;
  final String congratulatoryText;

  @override
  Widget build(final BuildContext context) => BlocConsumer<QuizzesBloc, QuizzesState>(
    builder: (final context, final state) => Padding(
      padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3w, horizontal: DsfrSpacings.s2w),
      child: switch (state) {
        QuizzesInProgress() => QuizzesInProgressWidget(inProgressState: state),
        QuizzesCompleted() => QuizzesCompletedWidget(completedState: state, name: name, congratulatoryText: congratulatoryText),
      },
    ),
    listener: (final context, final state) {
      if (state is QuizzesCompleted && state.isCompleted) {
        context.read<ActionBloc>().add(ActionMarkAsDone(id: id, type: ActionType.quiz));
      }
    },
  );
}
