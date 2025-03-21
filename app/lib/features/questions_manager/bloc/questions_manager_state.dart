import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/questions_manager/domain/cursor.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class QuestionsManagerState extends Equatable {
  const QuestionsManagerState();

  @override
  List<Object> get props => [];
}

@immutable
final class QuestionsManagerInitial extends QuestionsManagerState {
  const QuestionsManagerInitial();
}

@immutable
final class QuestionsManagerLoadSuccess extends QuestionsManagerState {
  const QuestionsManagerLoadSuccess({required this.cursor});

  final Cursor<Question> cursor;

  @override
  List<Object> get props => [cursor];
}

@immutable
final class QuestionManagerFinished extends QuestionsManagerState {
  const QuestionManagerFinished();
}
