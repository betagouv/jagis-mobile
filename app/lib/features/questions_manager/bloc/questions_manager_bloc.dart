import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_event.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_state.dart';
import 'package:app/features/questions_manager/domain/cursor.dart';
import 'package:app/features/questions_manager/domain/cursor_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionsManagerBloc extends Bloc<QuestionsManagerEvent, QuestionsManagerState> {
  QuestionsManagerBloc({required final CursorManager<Question> application}) : super(const QuestionsManagerInitial()) {
    on<QuestionsManagerFirstQuestionRequested>((final event, final emit) async {
      final result = await application.first();
      emit(QuestionsManagerLoadSuccess(cursor: result));
    });

    on<QuestionsManagerPreviousRequested>((final event, final emit) async {
      final blocState = state;
      if (blocState is! QuestionsManagerLoadSuccess) {
        return;
      }
      final result = await application.previous(blocState.cursor);
      emit(QuestionsManagerLoadSuccess(cursor: result));
    });

    on<QuestionsManagerNextRequested>((final event, final emit) async {
      final blocState = state;
      if (blocState is! QuestionsManagerLoadSuccess) {
        return;
      }
      final result = await application.next(blocState.cursor);
      if (result.isEnd) {
        emit(const QuestionManagerFinished());

        return;
      }
      emit(QuestionsManagerLoadSuccess(cursor: result));
    });

    on<QuestionsManagerLastQuestionRequested>((final event, final emit) async {
      final blocState = state;
      if (blocState is! QuestionsManagerLoadSuccess) {
        return;
      }
      final result = await application.next(blocState.cursor);
      if (result.isEnd) {
        emit(const QuestionManagerFinished());

        return;
      }
      emit(QuestionsManagerLoadSuccess(cursor: Cursor(elements: result.elements, index: result.elements.length)));
    });
  }
}
