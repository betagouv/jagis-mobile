import 'package:app/core/question/domain/question.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class QuestionEditState extends Equatable {
  const QuestionEditState();

  @override
  List<Object> get props => [];
}

@immutable
final class QuestionEditInitial extends QuestionEditState {
  const QuestionEditInitial();
}

@immutable
final class QuestionEditLoaded extends QuestionEditState {
  const QuestionEditLoaded({required this.question, required this.newQuestion, required this.updated});

  final Question question;
  final Question newQuestion;
  final bool updated;

  @override
  List<Object> get props => [question, newQuestion, updated];
}

@immutable
final class QuestionEditError extends QuestionEditState {
  const QuestionEditError({required this.id, required this.error});

  final String id;
  final String error;

  @override
  List<Object> get props => [id, error];
}
