import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class QuestionFlowEvent extends Equatable {
  const QuestionFlowEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class QuestionFlowFirstRequested extends QuestionFlowEvent {
  const QuestionFlowFirstRequested();
}

@immutable
final class QuestionFlowPreviousRequested extends QuestionFlowEvent {
  const QuestionFlowPreviousRequested();
}

@immutable
final class QuestionFlowNextRequested extends QuestionFlowEvent {
  const QuestionFlowNextRequested();
}

@immutable
final class QuestionFlowLastRequested extends QuestionFlowEvent {
  const QuestionFlowLastRequested();
}
