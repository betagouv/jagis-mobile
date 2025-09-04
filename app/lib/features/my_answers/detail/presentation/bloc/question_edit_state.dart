import 'package:app/core/question/domain/question.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum SubmissionStatus { idle, success }

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
  const QuestionEditLoaded({required this.question, required this.answers, required this.submissionStatus});

  final Question question;
  final Answers answers;
  final SubmissionStatus submissionStatus;

  @override
  List<Object> get props => [question, answers, submissionStatus];
}

@immutable
final class QuestionEditError extends QuestionEditState {
  const QuestionEditError({required this.id, required this.error});

  final String id;
  final String error;

  @override
  List<Object> get props => [id, error];
}
