import 'package:equatable/equatable.dart';

class MaifCityRisk extends Equatable {
  const MaifCityRisk._({
    required this.city,
    required this.cityCode,
    required this.numberOfCatNat,
    required this.droughtPercentage,
    required this.floodPercentage,
  });

  MaifCityRisk.fromJson(final Map<String, dynamic> json)
    : this._(
        city: json['nom_commune'] as String,
        cityCode: json['code_commune'] as String,
        numberOfCatNat: json['nombre_catastrophes_naturels'] as int?,
        droughtPercentage: json['pourcentage_commune_risque_secheresse_geotechnique'] as int?,
        floodPercentage: json['pourcentage_commune_risque_inondation'] as int?,
      );

  final String city;
  final String cityCode;
  final int? numberOfCatNat;
  final int? droughtPercentage;
  final int? floodPercentage;

  @override
  List<Object?> get props => [city, cityCode, numberOfCatNat, droughtPercentage, floodPercentage];
}
