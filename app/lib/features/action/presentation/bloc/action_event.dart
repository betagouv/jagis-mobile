import 'package:app/features/action/domain/action.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ActionEvent extends Equatable {
  const ActionEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ActionLoadRequested extends ActionEvent {
  const ActionLoadRequested({required this.id, required this.type});

  final String id;
  final ActionType type;

  @override
  List<Object> get props => [id, type];
}

@immutable
final class ActionMarkAsDone extends ActionEvent {
  const ActionMarkAsDone(this.action);

  final Action action;

  @override
  List<Object> get props => [action];
}
