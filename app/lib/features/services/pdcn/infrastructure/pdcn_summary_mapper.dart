import 'package:app/features/services/pdcn/domain/pdcn_summary.dart';

abstract final class PdcnSummaryMapper {
  const PdcnSummaryMapper._();

  static PdcnSummary fromJson(final Map<String, dynamic> json) {
    final address = [
      json['adresse_rue'] as String?,
      json['adresse_code_postal'] as String?,
      json['adresse_nom_ville'] as String?,
    ].where((final part) => part != null && part.isNotEmpty).join(', ');

    return PdcnSummary(
      id: json['id'] as String,
      name: json['titre'] as String,
      address: address,
      distanceInMeters: json['distance_metres'] as int,
    );
  }
}
