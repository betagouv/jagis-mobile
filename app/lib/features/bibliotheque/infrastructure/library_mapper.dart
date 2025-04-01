import 'package:app/features/bibliotheque/domain/library.dart';
import 'package:app/features/recommandations/infrastructure/recommandation_mapper.dart';

abstract final class LibraryMapper {
  const LibraryMapper._();

  static Library fromJson(final Map<String, dynamic> json) => Library(
    contents:
        (json['contenu'] as List<dynamic>).map((final e) => RecommandationMapper.fromJson(e as Map<String, dynamic>)).toList(),
    filters:
        (json['filtres'] as List<dynamic>).map((final e) => LibraryFilterMapper.fromJson(e as Map<String, dynamic>)).toList(),
  );
}

abstract final class LibraryFilterMapper {
  const LibraryFilterMapper._();

  static LibraryFilter fromJson(final Map<String, dynamic> json) =>
      LibraryFilter(code: json['code'] as String, title: json['label'] as String, isSelected: json['selected'] as bool);
}
