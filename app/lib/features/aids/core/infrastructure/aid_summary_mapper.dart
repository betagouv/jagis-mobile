import 'package:app/features/aids/core/domain/aid_summary.dart';
import 'package:app/features/articles/domain/partner.dart';

abstract final class AidSummaryMapper {
  const AidSummaryMapper._();

  static AidSummary fromJson(final Map<String, dynamic> json) => AidSummary(
    id: json['content_id'] as String,
    title: json['titre'] as String,
    // NOTE(erolley): not used for now.
    scale: geographicalScaleFromAPIString(json['echelle'] as String),
    maxAmount: json['montant_max'] as int,
    isFree: json['est_gratuit'] as bool,
    // TODO(erolley): to factorize with AidMapper maybe?
    partner: Partner(
      nom: json['partenaire_nom'] as String,
      url: json['partenaire_url'] as String?,
      logo: json['partenaire_logo_url'] as String? ?? '',
    ),
  );
}

GeographicalScale geographicalScaleFromAPIString(final String scale) => switch (scale) {
  'National' => GeographicalScale.country,
  'Région' => GeographicalScale.region,
  'Département' => GeographicalScale.departement,
  'Métropole' => GeographicalScale.metropole,
  'Agglomération' => GeographicalScale.agglomeration,
  'Communauté de communes' => GeographicalScale.cc,
  'Communauté urbaine' => GeographicalScale.cu,
  "Communauté d'agglomération" => GeographicalScale.ca,
  'Commune' => GeographicalScale.city,
  _ => throw ArgumentError('Unknown geographical scale: $scale'),
};
