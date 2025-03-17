import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class QuizQuestionEvent extends Equatable {
  const QuizQuestionEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class QuizQuestionResponseSelected extends QuizQuestionEvent {
  const QuizQuestionResponseSelected(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

@immutable
final class QuizQuestionValidationRequested extends QuizQuestionEvent {
  const QuizQuestionValidationRequested();
}
