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
    on<QuestionEditAnswersChanged>(_onAnswersChanged);
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
    final result = await _questionRepository.fetchQuestion(event.id);
    result.fold(
      (final failure) => emit(QuestionEditError(id: event.id, error: failure.message)),
      (final question) =>
          emit(QuestionEditLoaded(question: question, answers: question.answers, submissionStatus: SubmissionStatus.idle)),
    );
  }

  void _onAnswersChanged(final QuestionEditAnswersChanged event, final Emitter<QuestionEditState> emit) {
    final aState = state;
    if (aState is QuestionEditLoaded) {
      emit(QuestionEditLoaded(question: aState.question, answers: event.value, submissionStatus: SubmissionStatus.idle));
    }
  }

  Future<void> _onMosaicAucuneProposition(
    final QuestionEditMosaicAucuneProposition event,
    final Emitter<QuestionEditState> emit,
  ) async {
    final aState = state;
    switch (aState) {
      case QuestionEditLoaded():
        final question = aState.question;
        final currentAnswers = aState.answers;

        if (currentAnswers is AnswersMosaicBoolean) {
          final answers = currentAnswers.changeResponses([]);
          final result = await _questionRepository.update(question.code, answers);
          result.fold((final failure) => emit(QuestionEditError(id: question.code, error: failure.message)), (final r) {
            emit(QuestionEditLoaded(question: question, answers: answers, submissionStatus: SubmissionStatus.success));
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
        final newQuestion = aState.question;
        final answers = aState.answers;
        final result = await _questionRepository.update(newQuestion.code, answers);
        result.fold((final failure) => emit(QuestionEditError(id: newQuestion.code, error: failure.message)), (final r) {
          emit(QuestionEditLoaded(question: newQuestion, answers: answers, submissionStatus: SubmissionStatus.success));
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
        final newQuestion = aState.question;

        if (newQuestion.isMandatory) {
          return;
        }

        final result = await _questionRepository.skip(newQuestion);
        result.fold((final failure) => emit(QuestionEditError(id: newQuestion.code, error: failure.message)), (final r) {
          emit(QuestionEditLoaded(question: newQuestion, answers: aState.answers, submissionStatus: SubmissionStatus.success));
        });
      case QuestionEditInitial():
      case QuestionEditError():
        break;
    }
  }
}
