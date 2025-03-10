import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

class ThemeInfo extends Equatable {
  const ThemeInfo({
    required this.themeType,
    required this.isQuestionsNeeded,
    required this.sequenceId,
    required this.actionsRecommanded,
    required this.actionCount,
    required this.aidCount,
    required this.simulatorCount,
    required this.communeName,
  });

  final ThemeType themeType;
  final bool isQuestionsNeeded;
  final String sequenceId;
  final List<ActionSummary> actionsRecommanded;
  final int actionCount;
  final int aidCount;
  final int simulatorCount;
  final String communeName;

  bool get isActionsRecommandedNotEmpty => !isQuestionsNeeded && actionsRecommanded.isNotEmpty;
  bool get isActionsRecommandedEmpty => !isQuestionsNeeded && actionsRecommanded.isEmpty;

  @override
  List<Object> get props => [
    themeType,
    isQuestionsNeeded,
    sequenceId,
    actionsRecommanded,
    actionCount,
    aidCount,
    simulatorCount,
    communeName,
  ];
}
