import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

class ThemeInfo extends Equatable {
  const ThemeInfo({
    required this.themeType,
    required this.communeName,
    required this.isQuestionsNeeded,
    required this.sequenceId,
    required this.actionsRecommanded,
  });

  final ThemeType themeType;
  final String communeName;
  final bool isQuestionsNeeded;
  final String sequenceId;
  final List<ActionSummary> actionsRecommanded;

  bool get hasRecommandedActions => !isQuestionsNeeded && actionsRecommanded.isNotEmpty;
  bool get hasNoRecommandedActions => !isQuestionsNeeded && actionsRecommanded.isEmpty;

  @override
  List<Object?> get props => [themeType, communeName, isQuestionsNeeded, sequenceId, actionsRecommanded];
}
