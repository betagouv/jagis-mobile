import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class QuestionsManagerEvent extends Equatable {
  const QuestionsManagerEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class QuestionsManagerFirstQuestionRequested extends QuestionsManagerEvent {
  const QuestionsManagerFirstQuestionRequested();
}

@immutable
final class QuestionsManagerPreviousRequested extends QuestionsManagerEvent {
  const QuestionsManagerPreviousRequested();
}

@immutable
final class QuestionsManagerNextRequested extends QuestionsManagerEvent {
  const QuestionsManagerNextRequested();
}

@immutable
final class QuestionsManagerLastQuestionRequested extends QuestionsManagerEvent {
  const QuestionsManagerLastQuestionRequested();
}
