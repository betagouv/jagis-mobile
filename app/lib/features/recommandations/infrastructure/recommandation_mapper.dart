// ignore_for_file: no-equal-switch-expression-cases

import 'package:app/core/infrastructure/theme_type_mapper.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';

abstract final class RecommandationMapper {
  const RecommandationMapper._();

  static Recommandation fromJson(final Map<String, dynamic> json) => Recommandation(
    id: json['content_id'] as String,
    titre: json['titre'] as String,
    sousTitre: json['soustitre'] as String?,
    imageUrl: json['image_url'] as String?,
    thematique: ThemeTypeMapper.convert(json['thematique_principale'] as String),
  );
}
