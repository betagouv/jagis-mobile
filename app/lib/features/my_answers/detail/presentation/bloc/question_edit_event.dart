import 'package:app/core/question/domain/question.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class QuestionEditEvent extends Equatable {
  const QuestionEditEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class QuestionEditRecuperationDemandee extends QuestionEditEvent {
  const QuestionEditRecuperationDemandee(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

@immutable
final class QuestionEditAnswersChanged extends QuestionEditEvent {
  const QuestionEditAnswersChanged(this.value);

  final Answers value;

  @override
  List<Object> get props => [value];
}

@immutable
final class QuestionEditMosaicAucuneProposition extends QuestionEditEvent {
  const QuestionEditMosaicAucuneProposition();
}

@immutable
final class QuestionEditSkipRequested extends QuestionEditEvent {
  const QuestionEditSkipRequested();
}

@immutable
final class QuestionEditMisAJourDemandee extends QuestionEditEvent {
  const QuestionEditMisAJourDemandee();
}
