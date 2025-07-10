import 'package:app/core/infrastructure/theme_type_mapper.dart';
import 'package:app/features/aids/core/domain/aid_summary.dart';
import 'package:app/features/aids/core/domain/geographical_scale.dart';
import 'package:app/features/articles/domain/partner.dart';

abstract final class AidSummaryMapper {
  const AidSummaryMapper._();

  static AidSummary fromJson(final Map<String, dynamic> json) => AidSummary(
    id: json['content_id'] as String,
    themeType: ThemeTypeMapper.convert((json['thematiques'] as List<dynamic>?)?.cast<String>().firstOrNull ?? ''),
    title: json['titre'] as String,
    isFree: json['est_gratuit'] as bool,
    partner: json['partenaire_nom'] == null
        ? null
        : Partner(
            name: json['partenaire_nom'] as String,
            logo: json['partenaire_logo_url'] as String? ?? '',
            url: json['partenaire_url'] as String?,
          ),
    scale: json['echelle'] == null ? null : GeographicalScale.fromJson(json['echelle'] as String),
    maxAmount: json['montant_max'] as int?,
    simulatorUrl: json['url_simulateur'] as String?,
  );
}
