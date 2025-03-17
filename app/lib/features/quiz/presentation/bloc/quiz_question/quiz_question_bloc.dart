import 'package:app/features/quiz/domain/quiz.dart';
import 'package:app/features/quiz/infrastructure/quiz_repository.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_question/quiz_question_event.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_question/quiz_question_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizQuestionBloc extends Bloc<QuizQuestionEvent, QuizQuestionState> {
  QuizQuestionBloc({required final QuizRepository repository, required final Quiz quiz, required final bool isLastQuestion})
    : super(QuizQuestionState(quiz: quiz, isLastQuestion: isLastQuestion)) {
    on<QuizQuestionResponseSelected>((final event, final emit) => emit(state.copyWith(selectedResponse: event.value)));
    on<QuizQuestionValidationRequested>((final event, final emit) async {
      final isCorrect = state.quiz.responses.any((final e) => e.response == state.selectedResponse && e.exact);
      await repository.submitResponse(id: state.quiz.id, isCorrect: isCorrect);
      emit(state.copyWith(isCorrect: isCorrect));
    });
  }
}
