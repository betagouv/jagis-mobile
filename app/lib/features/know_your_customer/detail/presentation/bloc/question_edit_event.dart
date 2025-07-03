import 'package:app/core/question/domain/response_mosaic.dart';
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
final class QuestionEditChoixMultipleChangee extends QuestionEditEvent {
  const QuestionEditChoixMultipleChangee(this.value);

  final List<String> value;

  @override
  List<Object> get props => [value];
}

@immutable
final class QuestionEditChoixUniqueChangee extends QuestionEditEvent {
  const QuestionEditChoixUniqueChangee(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

@immutable
final class QuestionEditLibreChangee extends QuestionEditEvent {
  const QuestionEditLibreChangee(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

@immutable
final class QuestionEditMosaicChangee extends QuestionEditEvent {
  const QuestionEditMosaicChangee(this.value);

  final List<ResponseMosaic> value;

  @override
  List<Object> get props => [value];
}

@immutable
final class QuestionEditMosaicAucuneProposition extends QuestionEditEvent {
  const QuestionEditMosaicAucuneProposition();
}

@immutable
final class QuestionEditEntierChangee extends QuestionEditEvent {
  const QuestionEditEntierChangee(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

@immutable
final class QuestionEditDecimalChangee extends QuestionEditEvent {
  const QuestionEditDecimalChangee(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

@immutable
final class QuestionEditSkipRequested extends QuestionEditEvent {
  const QuestionEditSkipRequested();
}

@immutable
final class QuestionEditMisAJourDemandee extends QuestionEditEvent {
  const QuestionEditMisAJourDemandee();
}
