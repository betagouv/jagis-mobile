import 'package:app/core/infrastructure/theme_type_mapper.dart';
import 'package:app/features/actions/infrastructure/action_summary_mapper.dart';
import 'package:app/features/theme/core/domain/theme_info.dart';

abstract final class ThemeDataMapper {
  const ThemeDataMapper._();

  static ThemeInfo fromJson(final Map<String, dynamic> json) => ThemeInfo(
    themeType: ThemeTypeMapper.convert(json['thematique'] as String),
    communeName: json['nom_commune'] as String,
    isQuestionsNeeded: json['est_personnalisation_necessaire'] as bool,
    sequenceId: json['enchainement_questions_personnalisation'] as String,
    actionsRecommanded: (json['liste_actions_recommandees'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(ActionSummaryMapper.fromJson)
        .toList(),
    actionCount: json['nombre_actions'] as int,
    aidCount: json['nombre_aides'] as int,
    simulatorCount: json['nombre_simulateurs'] as int,
    recipeCount: json['nombre_recettes'] as int?,
  );
}
