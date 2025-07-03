import 'dart:async';

import 'package:app/core/question_flow/bloc/question_flow_event.dart';
import 'package:app/core/question_flow/bloc/question_flow_state.dart';
import 'package:app/core/question_flow/domain/current_question.dart';
import 'package:app/core/question_flow/domain/cursor_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionFlowBloc extends Bloc<QuestionFlowEvent, QuestionFlowState> {
  QuestionFlowBloc(this._application) : super(const QuestionFlowInitial()) {
    on<QuestionFlowFirstRequested>(_onFirstRequested);
    on<QuestionFlowPreviousRequested>(_onPreviousRequested);
    on<QuestionFlowNextRequested>(_onNextRequested);
    on<QuestionFlowLastRequested>(_onLastRequested);
  }

  final CursorManager<CurrentQuestion> _application;

  Future<void> _onFirstRequested(final QuestionFlowFirstRequested event, final Emitter<QuestionFlowState> emit) async {
    final result = await _application.first();
    emit(QuestionFlowLoadSuccess(cursor: result));
  }

  Future<void> _onPreviousRequested(final QuestionFlowPreviousRequested event, final Emitter<QuestionFlowState> emit) async {
    final blocState = state;
    if (blocState is! QuestionFlowLoadSuccess) {
      return;
    }
    final result = await _application.previous(blocState.cursor);
    emit(QuestionFlowLoadSuccess(cursor: result));
  }

  Future<void> _onNextRequested(final QuestionFlowNextRequested event, final Emitter<QuestionFlowState> emit) async {
    final blocState = state;
    if (blocState is! QuestionFlowLoadSuccess) {
      return;
    }

    final result = await _application.next(blocState.cursor);
    result.fold((final l) => emit(const QuestionFlowFinished()), (final r) => emit(QuestionFlowLoadSuccess(cursor: r)));
  }

  void _onLastRequested(final QuestionFlowLastRequested event, final Emitter<QuestionFlowState> emit) {
    final blocState = state;
    if (blocState is! QuestionFlowLoadSuccess) {
      return;
    }

    emit(const QuestionFlowFinished());
  }
}
