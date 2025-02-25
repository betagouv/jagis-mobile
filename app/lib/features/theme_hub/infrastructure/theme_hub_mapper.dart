import 'package:app/core/infrastructure/theme_type_mapper.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme_hub/domain/theme_hub_model.dart';

abstract final class ThemeHubMapper {
  const ThemeHubMapper._();

  static ThemeHubModel fromJson(final Map<String, dynamic> json) => ThemeHubModel(
    city: json['nom_commune'] as String,
    themes:
        (json['liste_thematiques'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(
              (final e) => ThemeHubThemeSummary(
                themeType: ThemeTypeMapper.convert(e['thematique'] as String),
                details: Map.fromEntries(
                  {
                    _mapDetail(e, key: 'nombre_actions', detailType: ThemeHubDetailType.action),
                    _mapDetail(e, key: 'nombre_aides', detailType: ThemeHubDetailType.aid),
                    _mapDetail(e, key: 'nombre_recettes', detailType: ThemeHubDetailType.recipe),
                    _mapDetail(e, key: 'nombre_simulateurs', detailType: ThemeHubDetailType.simulator),
                  }.whereType<MapEntry<ThemeHubDetailType, int>>(),
                ),
              ),
            )
            .toList()
          ..sort((final a, final b) {
            const order = [ThemeType.alimentation, ThemeType.transport, ThemeType.logement, ThemeType.consommation];

            return order.indexOf(a.themeType).compareTo(order.indexOf(b.themeType));
          }),
  );

  static MapEntry<ThemeHubDetailType, int>? _mapDetail(
    final Map<String, dynamic> e, {
    required final String key,
    required final ThemeHubDetailType detailType,
  }) {
    if (e[key] == null) {
      return null;
    }

    final value = (e[key] as num).toInt();

    return value <= 0 ? null : MapEntry(detailType, value);
  }
}
