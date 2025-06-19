import 'package:equatable/equatable.dart';

class PdcnDetail extends Equatable {
  const PdcnDetail({
    required this.title,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phone,
    required this.openingHours,
    required this.website,
    required this.distanceInMeters,
  });

  factory PdcnDetail.fromJson(final Map<String, dynamic> json) {
    final address = [
      json['adresse_rue'] as String?,
      json['adresse_code_postal'] as String?,
      json['adresse_nom_ville'] as String?,
    ].where((final part) => part != null && part.isNotEmpty).join(', ');

    return PdcnDetail(
      title: json['titre'] as String,
      description: json['description'] as String?,
      address: address,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      phone: json['phone'] as String?,
      openingHours: json['openhours_more_infos'] as String?,
      website: json['site_web'] as String?,
      distanceInMeters: json['distance_metres'] as int,
    );
  }

  final String title;
  final String? description;
  final String address;
  final double latitude;
  final double longitude;
  final String? phone;
  final String? openingHours;
  final String? website;
  final int distanceInMeters;

  @override
  List<Object?> get props => [title, description, address, latitude, longitude, phone, openingHours, website, distanceInMeters];
}
