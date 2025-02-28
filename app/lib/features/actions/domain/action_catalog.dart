import 'package:app/features/actions/domain/action_filter.dart';
import 'package:app/features/actions/domain/action_summary.dart';
import 'package:equatable/equatable.dart';

class ActionCatalog extends Equatable {
  const ActionCatalog({required this.actions, required this.themes, required this.alreadyConsulted});

  final List<ActionSummary> actions;
  final List<ActionFilter> themes;
  final bool alreadyConsulted;

  @override
  List<Object?> get props => [actions, themes, alreadyConsulted];
}
