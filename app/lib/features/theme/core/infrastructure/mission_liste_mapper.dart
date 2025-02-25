import 'package:app/core/infrastructure/theme_type_mapper.dart';
import 'package:app/features/theme/core/domain/mission_liste.dart';

abstract final class MissionListeMapper {
  const MissionListeMapper._();

  static MissionListe fromJson(final Map<String, dynamic> json) => MissionListe(
    code: json['code'] as String,
    titre: json['titre'] as String,
    progression: (json['progression'] as num).toInt(),
    progressionCible: (json['cible_progression'] as num).toInt(),
    estNouvelle: json['is_new'] as bool,
    imageUrl: json['image_url'] as String,
    themeType: ThemeTypeMapper.convert(json['thematique'] as String),
  );
}
