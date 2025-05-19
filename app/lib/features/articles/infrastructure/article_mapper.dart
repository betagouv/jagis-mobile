// ignore_for_file: avoid_dynamic_calls

import 'package:app/core/helpers/json_mapper.dart';
import 'package:app/core/source/source_mapper.dart';
import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/articles/domain/partner.dart';

abstract final class ArticleMapper {
  const ArticleMapper._();

  static Article fromJson({required final Map<String, dynamic> json}) => Article(
    id: json['content_id'] as String,
    imageUrl: json['image_url'] as String,
    titre: json['titre'] as String,
    sousTitre: json['soustitre'] as String?,
    contenu: json['contenu'] as String,
    partner:
        json['partenaire_nom'] == null
            ? null
            : Partner(
              name: json['partenaire_nom'] as String,
              logo: json['partenaire_logo_url'] as String,
              url: json['partenaire_url'] as String,
            ),
    sources: JsonHelpers.fromJsonList(json['sources'], SourceMapper.fromJson),
    isFavorite: json['favoris'] as bool,
    isRead: json['read_date'] != null,
  );
}
