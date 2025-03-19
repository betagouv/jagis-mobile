import 'package:app/features/quiz/domain/quiz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class QuizQuestionState extends Equatable {
  const QuizQuestionState({required this.quiz, required this.isLastQuestion, this.selectedResponse, this.isCorrect});

  final Quiz quiz;
  final String? selectedResponse;
  final bool? isCorrect;
  final bool isLastQuestion;
  String get explanation => quiz.article ?? (isCorrect! ? quiz.explicationOk : quiz.explicationKo) ?? '';

  QuizQuestionState copyWith({
    final Quiz? quiz,
    final bool? isLastQuestion,
    final String? selectedResponse,
    final bool? isCorrect,
  }) => QuizQuestionState(
    quiz: quiz ?? this.quiz,
    isLastQuestion: isLastQuestion ?? this.isLastQuestion,
    selectedResponse: selectedResponse ?? this.selectedResponse,
    isCorrect: isCorrect ?? this.isCorrect,
  );

  @override
  List<Object?> get props => [quiz, selectedResponse, isCorrect, isLastQuestion];
}
