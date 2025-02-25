import 'package:app/core/infrastructure/theme_type_mapper.dart';
import 'package:app/features/aids/core/domain/aid.dart';
import 'package:app/features/articles/domain/partner.dart';

abstract final class AidMapper {
  const AidMapper._();

  static Aid fromJson(final Map<String, dynamic> json) => Aid(
    themeType: ThemeTypeMapper.convert((json['thematiques'] as List<dynamic>).cast<String>().firstOrNull ?? ''),
    title: json['titre'] as String,
    content: json['contenu'] as String,
    amountMax: (json['montant_max'] as num?)?.toInt(),
    isFree: json['est_gratuit'] as bool,
    simulatorUrl: json['url_simulateur'] as String?,
    partner:
        json['partenaire_nom'] == null
            ? null
            : Partner(
              nom: json['partenaire_nom'] as String,
              url: json['partenaire_url'] as String?,
              logo: json['partenaire_logo_url'] as String? ?? '',
            ),
  );
}
