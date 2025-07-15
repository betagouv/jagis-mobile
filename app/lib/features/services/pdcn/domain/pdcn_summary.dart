import 'package:equatable/equatable.dart';

final class PdcnSummary extends Equatable {
  const PdcnSummary({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.distanceInMeters,
  });

  final String id;
  final String name;
  final String address;
  final String? description;
  final int distanceInMeters;

  @override
  List<Object?> get props => [id, name, address, description, distanceInMeters];
}
