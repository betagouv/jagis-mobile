import 'package:equatable/equatable.dart';

class Address extends Equatable {
  const Address({
    required this.latitude,
    required this.longitude,
    required this.houseNumber,
    required this.street,
    required this.postCode,
    required this.city,
    required this.cityCode,
  });

  final double? latitude;
  final double? longitude;
  final String? houseNumber;
  final String? street;
  final String postCode;
  final String city;
  final String cityCode;

  String get label => '${houseNumber ?? ''} ${street ?? ''} $postCode $city';
  bool get isFull => latitude != null && longitude != null && houseNumber != null && street != null;

  @override
  List<Object?> get props => [latitude, longitude, houseNumber, street, postCode, city, cityCode];
}
