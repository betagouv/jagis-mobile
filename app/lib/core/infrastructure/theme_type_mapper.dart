import 'package:app/features/theme/core/domain/theme_type.dart';

abstract final class ThemeTypeMapper {
  const ThemeTypeMapper._();

  static ThemeType convert(final String? type) => switch (type) {
    'alimentation' => ThemeType.alimentation,
    'transport' => ThemeType.transport,
    'consommation' => ThemeType.consommation,
    'logement' => ThemeType.logement,
    _ => ThemeType.decouverte,
  };
}
