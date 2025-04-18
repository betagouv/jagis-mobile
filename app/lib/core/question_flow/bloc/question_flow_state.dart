import 'package:app/core/question_flow/domain/current_question.dart';
import 'package:app/core/question_flow/domain/cursor.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class QuestionFlowState extends Equatable {
  const QuestionFlowState();

  @override
  List<Object> get props => [];
}

@immutable
final class QuestionFlowInitial extends QuestionFlowState {
  const QuestionFlowInitial();
}

@immutable
final class QuestionFlowLoadSuccess extends QuestionFlowState {
  const QuestionFlowLoadSuccess({required this.cursor});

  final Cursor<CurrentQuestion> cursor;

  @override
  List<Object> get props => [cursor];
}

@immutable
final class QuestionFlowFinished extends QuestionFlowState {
  const QuestionFlowFinished();
}
