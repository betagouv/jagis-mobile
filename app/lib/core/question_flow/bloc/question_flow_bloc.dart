import 'package:app/core/question_flow/bloc/question_flow_event.dart';
import 'package:app/core/question_flow/bloc/question_flow_state.dart';
import 'package:app/core/question_flow/domain/current_question.dart';
import 'package:app/core/question_flow/domain/cursor_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionFlowBloc extends Bloc<QuestionFlowEvent, QuestionFlowState> {
  QuestionFlowBloc(final CursorManager<CurrentQuestion> application) : super(const QuestionFlowInitial()) {
    on<QuestionFlowFirstRequested>((final event, final emit) async {
      final result = await application.first();
      emit(QuestionFlowLoadSuccess(cursor: result));
    });

    on<QuestionFlowPreviousRequested>((final event, final emit) async {
      final blocState = state;
      if (blocState is! QuestionFlowLoadSuccess) {
        return;
      }
      final result = await application.previous(blocState.cursor);
      emit(QuestionFlowLoadSuccess(cursor: result));
    });

    on<QuestionFlowNextRequested>((final event, final emit) async {
      final blocState = state;
      if (blocState is! QuestionFlowLoadSuccess) {
        return;
      }

      final result = await application.next(blocState.cursor);
      result.fold((final l) => emit(const QuestionFlowFinished()), (final r) => emit(QuestionFlowLoadSuccess(cursor: r)));
    });

    on<QuestionFlowLastRequested>((final event, final emit) async {
      final blocState = state;
      if (blocState is! QuestionFlowLoadSuccess) {
        return;
      }

      emit(const QuestionFlowFinished());
    });
  }
}
