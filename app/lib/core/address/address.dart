import 'package:app/core/helpers/json_mapper.dart';
import 'package:equatable/equatable.dart';

class Address extends Equatable {
  const Address({
    required this.latitude,
    required this.longitude,
    required this.houseNumber,
    required this.street,
    required this.postCode,
    required this.municipality,
    required this.cityCode,
  });

  Address.fromJson(final Map<String, dynamic> json)
    : this(
        latitude: JsonHelpers.toNullable<num>(json, 'latitude')?.toDouble(),
        longitude: JsonHelpers.toNullable<num>(json, 'longitude')?.toDouble(),
        houseNumber: JsonHelpers.toNullable(json, 'numero_rue'),
        street: JsonHelpers.toNullable(json, 'rue'),
        postCode: json['code_postal'] as String,
        municipality: json['commune'] as String,
        cityCode: json['code_commune'] as String,
      );

  final double? latitude;
  final double? longitude;
  final String? houseNumber;
  final String? street;
  final String postCode;
  final String municipality;

  final String cityCode;
  String get label => '${houseNumber ?? ''} ${street ?? ''} $postCode $municipality';
  bool get isFull => latitude != null && longitude != null && houseNumber != null && street != null;

  bool get isNotFull => !isFull;

  Address copyWith({
    final double? latitude,
    final double? longitude,
    final String? houseNumber,
    final String? street,
    final String? postCode,
    final String? municipality,
    final String? cityCode,
  }) => Address(
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    houseNumber: houseNumber ?? this.houseNumber,
    street: street ?? this.street,
    postCode: postCode ?? this.postCode,
    municipality: municipality ?? this.municipality,
    cityCode: cityCode ?? this.cityCode,
  );

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
    'numero_rue': houseNumber,
    'rue': street,
    'code_postal': postCode,
    'code_commune': cityCode,
  };

  @override
  List<Object?> get props => [latitude, longitude, houseNumber, street, postCode, municipality, cityCode];
}
