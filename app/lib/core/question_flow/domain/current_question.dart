import 'package:app/core/question/domain/question.dart';
import 'package:equatable/equatable.dart';

class CurrentQuestion extends Equatable {
  const CurrentQuestion({required this.question, required this.currentPosition, required this.totalNumberOfQuestions});

  final Question question;
  final int currentPosition;
  final int totalNumberOfQuestions;

  @override
  List<Object> get props => [question, currentPosition, totalNumberOfQuestions];
}
