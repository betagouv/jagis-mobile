import 'package:app/core/helpers/json_mapper.dart';
import 'package:app/features/services/maif/domain/maif.dart';

abstract final class MaifCommuneDataMapper {
  const MaifCommuneDataMapper._();

  static MaifCommuneData fromJson(final Map<String, dynamic> json) => MaifCommuneData(
    latitude: JsonHelpers.toNullable<num>(json, 'latitude')?.toDouble(),
    longitude: JsonHelpers.toNullable<num>(json, 'longitude')?.toDouble(),
    houseNumber: JsonHelpers.toNullable(json, 'numero_rue'),
    street: JsonHelpers.toNullable(json, 'rue'),
    postCode: json['code_postal'] as String,
    city: json['commune_label'] as String,
    cityCode: json['code_commune'] as String,
    numberOfCatNat: json['nombre_arrets_catnat'] as int,
    droughtPercentage: json['pourcentage_surface_secheresse_geotech'] as int,
    floodPercentage: json['pourcentage_surface_inondation'] as int,
  );
}
