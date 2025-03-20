import 'package:app/features/action/domain/action.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum ActionStatus { initial, inProgress, success, failure }

@immutable
final class ActionState extends Equatable {
  const ActionState({required this.status, this.action, this.errorMessage});
  const ActionState.initial() : this(status: ActionStatus.initial);
  const ActionState.inProgress() : this(status: ActionStatus.inProgress);
  const ActionState.success({required final Action action}) : this(status: ActionStatus.success, action: action);
  const ActionState.failure({required final String errorMessage})
    : this(status: ActionStatus.failure, errorMessage: errorMessage);

  final ActionStatus status;
  final Action? action;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, action, errorMessage];
}
