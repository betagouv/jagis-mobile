import 'package:app/features/quiz/domain/quiz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class QuizzesState extends Equatable {
  const QuizzesState();

  @override
  List<Object> get props => [];
}

@immutable
final class QuizzesInProgress extends QuizzesState {
  const QuizzesInProgress({required this.quizzes, required this.currentIndex});

  final List<Quiz> quizzes;
  final int currentIndex;
  bool get isLastQuestion => currentIndex == quizzes.length - 1;

  QuizzesInProgress copyWith({final List<Quiz>? quizzes, final int? currentIndex}) =>
      QuizzesInProgress(quizzes: quizzes ?? this.quizzes, currentIndex: currentIndex ?? this.currentIndex);

  @override
  List<Object> get props => [quizzes, currentIndex];
}

@immutable
final class QuizzesCompleted extends QuizzesState {
  const QuizzesCompleted({required this.correctAnswerCount, required this.totalQuestionsCount});

  final int correctAnswerCount;
  final int totalQuestionsCount;

  @override
  List<Object> get props => [correctAnswerCount, totalQuestionsCount];
}
