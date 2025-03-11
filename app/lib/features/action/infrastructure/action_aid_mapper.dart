import 'package:app/features/action/domain/action_aid.dart';
import 'package:app/features/articles/domain/partner.dart';

abstract final class ActionAidMapper {
  const ActionAidMapper._();

  static ActionAid fromJson(final Map<String, dynamic> json) => ActionAid(
    title: json['titre'] as String,
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
