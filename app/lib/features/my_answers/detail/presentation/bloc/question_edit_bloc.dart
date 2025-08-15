// ignore_for_file: avoid-high-cyclomatic-complexity

import 'dart:async';

import 'package:app/core/question/domain/question.dart';
import 'package:app/core/question/infrastructure/question_repository.dart';
import 'package:app/features/my_answers/detail/presentation/bloc/question_edit_event.dart';
import 'package:app/features/my_answers/detail/presentation/bloc/question_edit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionEditBloc extends Bloc<QuestionEditEvent, QuestionEditState> {
  QuestionEditBloc(this._questionRepository) : super(const QuestionEditInitial()) {
    on<QuestionEditRecuperationDemandee>(_onRecuperationDemandee);
    on<QuestionEditChoixMultipleChangee>(_onChoixMultipleChangee);
    on<QuestionEditChoixUniqueChangee>(_onChoixUniqueChangee);
    on<QuestionEditLibreChangee>(_onLibreChangee);
    on<QuestionEditEntierChangee>(_onEntierChangee);
    on<QuestionEditDecimalChangee>(_onDecimalChangee);
    on<QuestionEditMosaicChangee>(_onMosaicChangee);
    on<QuestionEditMosaicAucuneProposition>(_onMosaicAucuneProposition);
    on<QuestionEditSkipRequested>(_onSkipRequested);
    on<QuestionEditMisAJourDemandee>(_onMiseAJourDemandee);
  }

  final QuestionRepository _questionRepository;

  Future<void> _onRecuperationDemandee(
    final QuestionEditRecuperationDemandee event,
    final Emitter<QuestionEditState> emit,
  ) async {
    emit(const QuestionEditInitial());
    final result = await _questionRepository.fetchQuestion(id: event.id);

    result.fold(
      (final l) => emit(QuestionEditError(id: event.id, error: l.toString())),
      (final r) => emit(QuestionEditLoaded(question: r, newQuestion: r, updated: false)),
    );
  }

  void _onChoixMultipleChangee(final QuestionEditChoixMultipleChangee event, final Emitter<QuestionEditState> emit) {
    final aState = state;
    if (aState is QuestionEditLoaded) {
      final question = aState.question;
      final newQuestion = aState.newQuestion;

      if (question is QuestionMultipleChoice && newQuestion is QuestionMultipleChoice) {
        emit(QuestionEditLoaded(question: question, newQuestion: newQuestion.changeResponses(event.value), updated: false));
      }
    }
  }

  void _onChoixUniqueChangee(final QuestionEditChoixUniqueChangee event, final Emitter<QuestionEditState> emit) {
    final aState = state;
    if (aState is QuestionEditLoaded) {
      final question = aState.question;
      final newQuestion = aState.newQuestion;

      if (question is QuestionSingleChoice && newQuestion is QuestionSingleChoice) {
        emit(QuestionEditLoaded(question: question, newQuestion: newQuestion.changeResponses([event.value]), updated: false));
      }
    }
  }

  void _onLibreChangee(final QuestionEditLibreChangee event, final Emitter<QuestionEditState> emit) {
    final aState = state;
    if (aState is QuestionEditLoaded) {
      final question = aState.question;
      final newQuestion = aState.newQuestion;

      if (question is QuestionOpen && newQuestion is QuestionOpen) {
        emit(QuestionEditLoaded(question: question, newQuestion: newQuestion.changeResponse(event.value), updated: false));
      }
    }
  }

  void _onEntierChangee(final QuestionEditEntierChangee event, final Emitter<QuestionEditState> emit) {
    final aState = state;
    if (aState is QuestionEditLoaded) {
      final question = aState.question;
      final newQuestion = aState.newQuestion;
      if (question is QuestionInteger && newQuestion is QuestionInteger) {
        emit(QuestionEditLoaded(question: question, newQuestion: newQuestion.changeResponse(event.value), updated: false));
      }
    }
  }

  void _onDecimalChangee(final QuestionEditDecimalChangee event, final Emitter<QuestionEditState> emit) {
    final aState = state;
    if (aState is QuestionEditLoaded) {
      final question = aState.question;
      final newQuestion = aState.newQuestion;
      if (question is QuestionDecimal && newQuestion is QuestionDecimal) {
        emit(QuestionEditLoaded(question: question, newQuestion: newQuestion.changeResponse(event.value), updated: false));
      }
    }
  }

  void _onMosaicChangee(final QuestionEditMosaicChangee event, final Emitter<QuestionEditState> emit) {
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
  }

  Future<void> _onMosaicAucuneProposition(
    final QuestionEditMosaicAucuneProposition event,
    final Emitter<QuestionEditState> emit,
  ) async {
    final aState = state;
    switch (aState) {
      case QuestionEditLoaded():
        final currentQuestion = aState.newQuestion;
        if (currentQuestion is QuestionMosaicBoolean) {
          final modifiedQuestion = currentQuestion.changeResponses([]);
          final result = await _questionRepository.update(modifiedQuestion);
          result.fold((final l) => emit(QuestionEditError(id: aState.question.code.value, error: l.toString())), (final r) {
            emit(QuestionEditLoaded(question: modifiedQuestion, newQuestion: modifiedQuestion, updated: true));
            emit(QuestionEditLoaded(question: modifiedQuestion, newQuestion: modifiedQuestion, updated: false));
          });
        }
      case QuestionEditInitial():
      case QuestionEditError():
        break;
    }
  }

  Future<void> _onMiseAJourDemandee(final QuestionEditMisAJourDemandee event, final Emitter<QuestionEditState> emit) async {
    final aState = state;
    switch (aState) {
      case QuestionEditLoaded():
        final newQuestion = aState.newQuestion;

        final result = await _questionRepository.update(newQuestion);
        result.fold((final l) => emit(QuestionEditError(id: aState.question.code.value, error: l.toString())), (final r) {
          emit(QuestionEditLoaded(question: newQuestion, newQuestion: newQuestion, updated: true));
          emit(QuestionEditLoaded(question: newQuestion, newQuestion: newQuestion, updated: false));
        });
      case QuestionEditInitial():
      case QuestionEditError():
        break;
    }
  }

  Future<void> _onSkipRequested(final QuestionEditSkipRequested event, final Emitter<QuestionEditState> emit) async {
    final aState = state;
    switch (aState) {
      case QuestionEditLoaded():
        final newQuestion = aState.newQuestion;

        final result = await _questionRepository.skip(newQuestion);
        result.fold((final l) => emit(QuestionEditError(id: aState.question.code.value, error: l.toString())), (final r) {
          emit(QuestionEditLoaded(question: newQuestion, newQuestion: newQuestion, updated: true));
          emit(QuestionEditLoaded(question: newQuestion, newQuestion: newQuestion, updated: false));
        });
      case QuestionEditInitial():
      case QuestionEditError():
        break;
    }
  }
}
