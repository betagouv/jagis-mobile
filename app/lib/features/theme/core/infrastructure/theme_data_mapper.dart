import 'package:app/core/infrastructure/theme_type_mapper.dart';
import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/theme/core/domain/theme_info.dart';

abstract final class ThemeDataMapper {
  const ThemeDataMapper._();

  static ThemeInfo fromJson(final Map<String, dynamic> json) => ThemeInfo(
    themeType: ThemeTypeMapper.convert(json['thematique'] as String),
    communeName: json['nom_commune'] as String,
    isQuestionsNeeded: json['est_personnalisation_necessaire'] as bool,
    sequenceId: json['enchainement_questions_personnalisation'] as String,
    actionsRecommanded: ActionSummary.fromJsonList(json['liste_actions_recommandees'] as List<dynamic>),
  );
}
