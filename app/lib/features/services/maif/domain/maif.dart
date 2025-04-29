import 'package:equatable/equatable.dart';

class MaifCommuneData extends Equatable {
  const MaifCommuneData({
    required this.latitude,
    required this.longitude,
    required this.houseNumber,
    required this.street,
    required this.postCode,
    required this.city,
    required this.cityCode,
    required this.numberOfCatNat,
    required this.droughtPercentage,
    required this.floodPercentage,
  });

  final double? latitude;
  final double? longitude;
  final String? houseNumber;
  final String? street;
  final String postCode;
  final String city;
  final String cityCode;
  final int numberOfCatNat;
  final int droughtPercentage;
  final int floodPercentage;

  @override
  List<Object?> get props => [
    latitude,
    longitude,
    houseNumber,
    street,
    postCode,
    city,
    cityCode,
    numberOfCatNat,
    droughtPercentage,
    floodPercentage,
  ];
}
