import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

// FIXME(lsaudon): Faire un dto
class ThemeInfo extends Equatable {
  const ThemeInfo({
    required this.themeType,
    required this.communeName,
    required this.isQuestionsNeeded,
    required this.sequenceId,
    required this.actionsRecommanded,
    required this.actionCount,
    required this.aidCount,
    required this.simulatorCount,
    required this.recipeCount,
  });

  final ThemeType themeType;
  final String communeName;
  final bool isQuestionsNeeded;
  final String sequenceId;
  final List<ActionSummary> actionsRecommanded;
  final int actionCount;
  final int aidCount;
  final int simulatorCount;
  final int? recipeCount;

  bool get hasRecommandedActions => !isQuestionsNeeded && actionsRecommanded.isNotEmpty;
  bool get hasNoRecommandedActions => !isQuestionsNeeded && actionsRecommanded.isEmpty;

  @override
  List<Object?> get props => [
    themeType,
    communeName,
    isQuestionsNeeded,
    sequenceId,
    actionsRecommanded,
    actionCount,
    aidCount,
    simulatorCount,
    recipeCount,
  ];
}
