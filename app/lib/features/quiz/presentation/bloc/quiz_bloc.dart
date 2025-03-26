import 'package:app/features/quiz/infrastructure/quiz_repository.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_event.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc({required final QuizRepository quizRepository}) : super(const QuizState.empty()) {
    on<QuizRecuperationDemandee>((final event, final emit) async {
      final result = await quizRepository.recupererQuiz(event.id);
      if (result.isRight()) {
        final quiz = result.getRight().getOrElse(() => throw Exception());
        emit(state.copyWith(quiz: quiz));
      }
    });
    on<QuizReponseSelectionnee>((final event, final emit) => emit(state.copyWith(reponse: Some(event.valeur))));
    on<QuizValidationDemandee>((final event, final emit) async {
      final estExacte = state.quiz.responses.any((final e) => e.response == state.reponse.getOrElse(() => '') && e.exact);
      await quizRepository.submitResponse(id: state.quiz.id, isCorrect: estExacte);
      emit(state.copyWith(estExacte: Some(estExacte)));
    });
  }
}
