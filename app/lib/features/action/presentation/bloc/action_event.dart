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
  const ActionMarkAsDone({required this.id, required this.type});

  final String id;
  final ActionType type;

  @override
  List<Object> get props => [id, type];
}
