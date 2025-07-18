import 'package:app/features/actions/domain/action_summary.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class WinterActionsState extends Equatable {
  const WinterActionsState({required this.actions});

  final List<ActionSummary> actions;

  @override
  List<Object> get props => [actions];
}
