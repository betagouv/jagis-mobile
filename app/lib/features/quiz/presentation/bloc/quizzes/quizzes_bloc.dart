import 'package:app/features/quiz/domain/quiz.dart';
import 'package:app/features/quiz/infrastructure/quizzes_repository.dart';
import 'package:app/features/quiz/presentation/bloc/quizzes/quizzes_event.dart';
import 'package:app/features/quiz/presentation/bloc/quizzes/quizzes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizzesBloc extends Bloc<QuizzesEvent, QuizzesState> {
  QuizzesBloc({required final QuizzesRepository repository, required final List<Quiz> quizzes, required final String id})
    : super(QuizzesInProgress(quizzes: quizzes, currentIndex: 0)) {
    on<QuizzesRepeatRequested>((final event, final emit) {
      emit(QuizzesInProgress(quizzes: quizzes, currentIndex: 0));
    });
    on<QuizzesNextQuestion>((final event, final emit) async {
      if (state is QuizzesInProgress) {
        final currentState = state as QuizzesInProgress;
        if (currentState.currentIndex < currentState.quizzes.length - 1) {
          emit(currentState.copyWith(currentIndex: currentState.currentIndex + 1));
        } else {
          final result = await repository.score(id: id);
          result.fold((final l) => emit(const QuizzesCompleted(correctAnswerCount: 0, totalQuestionsCount: 0)), (final r) {
            emit(QuizzesCompleted(correctAnswerCount: r.correctAnswerCount, totalQuestionsCount: r.totalQuestionsCount));
          });
        }
      }
    });
  }
}
