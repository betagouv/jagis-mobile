// ignore_for_file: no-equal-switch-expression-cases

import 'package:app/core/infrastructure/theme_type_mapper.dart';
import 'package:app/features/recommandations/domain/recommendation.dart';

abstract final class RecommandationMapper {
  const RecommandationMapper._();

  static Recommendation fromJson(final Map<String, dynamic> json) => Recommendation(
    id: json['content_id'] as String,
    titre: json['titre'] as String,
    sousTitre: json['soustitre'] as String?,
    imageUrl: json['image_url'] as String?,
    thematique: ThemeTypeMapper.convert(json['thematique_principale'] as String),
  );
}
