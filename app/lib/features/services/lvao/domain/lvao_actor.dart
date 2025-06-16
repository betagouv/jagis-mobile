import 'package:equatable/equatable.dart';

class LvaoActor extends Equatable {
  const LvaoActor._({
    required this.id,
    required this.name,
    required this.address,
    required this.distanceInMeters,
    required this.latitude,
    required this.longitude,
    required this.sources,
  });

  LvaoActor.fromJson(final Map<String, dynamic> json)
    : this._(
        id: json['id'] as String,
        name: json['titre'] as String,
        address: json['adresse_rue'] as String,
        distanceInMeters: json['distance_metres'] as int?,
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
        sources: json.containsKey('sources') ? (json['sources'] as List<dynamic>).map((final e) => e as String).toList() : [],
      );

  final String id;
  final String name;
  final String address;
  final int? distanceInMeters;
  final double latitude;
  final double longitude;
  final List<String> sources;
  @override
  List<Object?> get props => [id, name, address, distanceInMeters, latitude, longitude, sources];
}
