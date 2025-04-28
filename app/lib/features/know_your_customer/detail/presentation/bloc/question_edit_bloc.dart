// ignore_for_file: avoid-high-cyclomatic-complexity

import 'package:app/core/question/domain/question.dart';
import 'package:app/core/question/infrastructure/question_repository.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/question_edit_event.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/question_edit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionEditBloc extends Bloc<QuestionEditEvent, QuestionEditState> {
  QuestionEditBloc(final QuestionRepository questionRepository) : super(const QuestionEditInitial()) {
    on<QuestionEditRecuperationDemandee>((final event, final emit) async {
      emit(const QuestionEditInitial());
      final result = await questionRepository.fetchQuestion(id: event.id);

      result.fold(
        (final l) => emit(QuestionEditError(id: event.id, error: l.toString())),
        (final r) => emit(QuestionEditLoaded(question: r, newQuestion: r, updated: false)),
      );
    });

    on<QuestionEditChoixMultipleChangee>((final event, final emit) async {
      final aState = state;
      if (aState is QuestionEditLoaded) {
        final question = aState.question;
        final newQuestion = aState.newQuestion;

        if (question is QuestionMultipleChoice && newQuestion is QuestionMultipleChoice) {
          emit(QuestionEditLoaded(question: question, newQuestion: newQuestion.changeResponses(event.value), updated: false));
        }
      }
    });

    on<QuestionEditChoixUniqueChangee>((final event, final emit) async {
      final aState = state;
      if (aState is QuestionEditLoaded) {
        final question = aState.question;
        final newQuestion = aState.newQuestion;

        if (question is QuestionSingleChoice && newQuestion is QuestionSingleChoice) {
          emit(QuestionEditLoaded(question: question, newQuestion: newQuestion.changeResponses([event.value]), updated: false));
        }
      }
    });

    on<QuestionEditLibreChangee>((final event, final emit) async {
      final aState = state;
      if (aState is QuestionEditLoaded) {
        final question = aState.question;
        final newQuestion = aState.newQuestion;

        if (question is QuestionOpen && newQuestion is QuestionOpen) {
          emit(QuestionEditLoaded(question: question, newQuestion: newQuestion.changeResponse(event.value), updated: false));
        }
      }
    });

    on<QuestionEditEntierChangee>((final event, final emit) async {
      final aState = state;
      if (aState is QuestionEditLoaded) {
        final question = aState.question;
        final newQuestion = aState.newQuestion;
        if (question is QuestionInteger && newQuestion is QuestionInteger) {
          emit(QuestionEditLoaded(question: question, newQuestion: newQuestion.changeResponse(event.value), updated: false));
        }
      }
    });

    on<QuestionEditDecimalChangee>((final event, final emit) async {
      final aState = state;
      if (aState is QuestionEditLoaded) {
        final question = aState.question;
        final newQuestion = aState.newQuestion;
        if (question is QuestionDecimal && newQuestion is QuestionDecimal) {
          emit(QuestionEditLoaded(question: question, newQuestion: newQuestion.changeResponse(event.value), updated: false));
        }
      }
    });

    on<QuestionEditMosaicChangee>((final event, final emit) async {
      final aState = state;
      if (aState is QuestionEditLoaded) {
        final question = aState.question;
        final newQuestion = aState.newQuestion;

        if (question is QuestionMosaicBoolean && newQuestion is QuestionMosaicBoolean) {
          emit(
            QuestionEditLoaded(
              question: question,
              newQuestion: newQuestion.changeResponses(
                event.value.where((final e) => e.isSelected).map((final e) => e.label).toList(),
              ),
              updated: false,
            ),
          );
        }
      }
    });
    on<QuestionEditMosaicAucuneProposition>((final event, final emit) async {
      final aState = state;
      switch (aState) {
        case QuestionEditLoaded():
          final currentQuestion = aState.newQuestion;
          if (currentQuestion is QuestionMosaicBoolean) {
            final modifiedQuestion = currentQuestion.changeResponses([]);
            final result = await questionRepository.update(modifiedQuestion);
            result.fold((final l) => emit(QuestionEditError(id: aState.question.code.value, error: l.toString())), (final r) {
              emit(QuestionEditLoaded(question: modifiedQuestion, newQuestion: modifiedQuestion, updated: true));
              emit(QuestionEditLoaded(question: modifiedQuestion, newQuestion: modifiedQuestion, updated: false));
            });
          }

        default:
          return;
      }
    });
    on<QuestionEditMisAJourDemandee>((final event, final emit) async {
      final aState = state;
      switch (aState) {
        case QuestionEditLoaded():
          final newQuestion = aState.newQuestion;

          // TODO(erolley): what should be the behavior here?
          // Context: I force the update of the question even if the responses
          // are empty for entier and decimal. This allow to have the 'question
          // suivante' to be 'passer la question' when the user empty the input
          // even for already answered questions.
          if (newQuestion.responsesDisplay().isEmpty) {
            emit(QuestionEditLoaded(question: newQuestion, newQuestion: newQuestion, updated: true));
            emit(QuestionEditLoaded(question: newQuestion, newQuestion: newQuestion, updated: false));

            return;
          }
          final result = await questionRepository.update(newQuestion);
          result.fold((final l) => emit(QuestionEditError(id: aState.question.code.value, error: l.toString())), (final r) {
            emit(QuestionEditLoaded(question: newQuestion, newQuestion: newQuestion, updated: true));
            emit(QuestionEditLoaded(question: newQuestion, newQuestion: newQuestion, updated: false));
          });
        default:
          return;
      }
    });
  }
}
