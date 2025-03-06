import 'package:app/core/infrastructure/theme_type_mapper.dart';
import 'package:app/features/theme/core/domain/theme_info.dart';

abstract final class ThemeDataMapper {
  const ThemeDataMapper._();

  static ThemeInfo fromJson(final Map<String, dynamic> json) => ThemeInfo(
    themeType: ThemeTypeMapper.convert(json['thematique'] as String),
    isQuestionsNeeded: json['est_personnalisation_necessaire'] as bool,
    sequenceId: json['enchainement_questions_personnalisation'] as String,
    actionsRecommanded: json['liste_actions_recommandees'] as List<dynamic>,
    actionCount: json['nombre_actions'] as int,
    aidCount: json['nombre_aides'] as int,
    simulatorCount: json['nombre_simulateurs'] as int,
    communeName: json['nom_commune'] as String,
  );
}
