import 'package:app/features/services/pres_de_chez_vous/domain/pres_de_chez_vous_summary.dart';

abstract final class PresDeChezVousSummaryMapper {
  const PresDeChezVousSummaryMapper._();

  static PresDeChezVousSummary fromJson(final Map<String, dynamic> json) => PresDeChezVousSummary(
    name: json['titre'] as String,
    address: '${json['adresse_rue'] as String} ${json['adresse_code_postal'] as String} ${json['adresse_nom_ville'] as String}',
    distanceInMeters: json['distance_metres'] as int,
  );
}
