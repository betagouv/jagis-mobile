import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ActionsEvent extends Equatable {
  const ActionsEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ActionsLoadRequested extends ActionsEvent {
  const ActionsLoadRequested();
}

@immutable
final class ActionsFilterByTitleRequested extends ActionsEvent {
  const ActionsFilterByTitleRequested(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

@immutable
final class ActionsFilterByThemeRequested extends ActionsEvent {
  const ActionsFilterByThemeRequested(this.theme);

  final String theme;

  @override
  List<Object> get props => [theme];
}

@immutable
final class ActionsFilterByConsultedRequested extends ActionsEvent {
  const ActionsFilterByConsultedRequested(this.value);

  final bool value;

  @override
  List<Object> get props => [value];
}
