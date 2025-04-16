import 'package:equatable/equatable.dart';

final class PresDeChezVousSummary extends Equatable {
  const PresDeChezVousSummary({required this.name, required this.address, required this.distanceInMeters});

  final String name;
  final String address;
  final int distanceInMeters;

  @override
  List<Object?> get props => [name, address, distanceInMeters];
}
