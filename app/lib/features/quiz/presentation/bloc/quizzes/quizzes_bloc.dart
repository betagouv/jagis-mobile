import 'package:app/features/action/infrastructure/action_repository.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/quiz/domain/quiz.dart';
import 'package:app/features/quiz/presentation/bloc/quizzes/quizzes_event.dart';
import 'package:app/features/quiz/presentation/bloc/quizzes/quizzes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizzesBloc extends Bloc<QuizzesEvent, QuizzesState> {
  QuizzesBloc({required final List<Quiz> quizzes, required final String id, required final ActionRepository actionRepository})
    : super(QuizzesInProgress(quizzes: quizzes, currentIndex: 0)) {
    on<QuizzesNextQuestion>((final event, final emit) async {
      if (state is QuizzesInProgress) {
        final currentState = state as QuizzesInProgress;
        if (currentState.currentIndex < currentState.quizzes.length - 1) {
          emit(currentState.copyWith(currentIndex: currentState.currentIndex + 1));
        } else {
          // actions/quizz/$name/score
          // {"nombre_bonnes_reponses":3,"nombre_quizz_done":5}
          await actionRepository.markAsDone(type: ActionType.quiz, id: id);
          emit(const QuizzesCompleted(correctAnswerCount: 3, totalQuestionsCount: 5));
        }
      }
    });
  }
}
