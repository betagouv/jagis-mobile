import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class QuizzesEvent extends Equatable {
  const QuizzesEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class QuizzesRepeatRequested extends QuizzesEvent {
  const QuizzesRepeatRequested();
}

@immutable
final class QuizzesNextQuestion extends QuizzesEvent {
  const QuizzesNextQuestion();
}
