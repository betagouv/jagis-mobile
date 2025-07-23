import 'package:app/core/address/address.dart';
import 'package:app/features/profil/home/domain/area.dart';
import 'package:app/features/profil/home/domain/energy_performance.dart';
import 'package:app/features/profil/home/domain/type_de_logement.dart';
import 'package:equatable/equatable.dart';

class Home extends Equatable {
  const Home({
    required this.address,
    required this.numberOfAdults,
    required this.numberOfChildren,
    required this.housingType,
    required this.isOwner,
    required this.area,
    required this.over15Years,
    required this.energyPerformance,
    required this.isPrmPresent,
    required this.isPrmObsolete,
    required this.isAddressComplete,
  });

  final Address address;
  final int? numberOfAdults;
  final int? numberOfChildren;
  final TypeDeLogement? housingType;
  final bool? isOwner;
  final Area? area;
  final bool? over15Years;
  final EnergyPerformance? energyPerformance;
  final bool isPrmPresent;
  final bool isPrmObsolete;
  final bool isAddressComplete;

  Home copyWith({
    final Address? address,
    final int? numberOfAdults,
    final int? numberOfChildren,
    final TypeDeLogement? housingType,
    final bool? isOwner,
    final Area? area,
    final bool? over15Years,
    final EnergyPerformance? energyPerformance,
    final bool? isPrmPresent,
    final bool? isPrmObsolete,
    final bool? isAddressComplete,
  }) => Home(
    address: address ?? this.address,
    numberOfAdults: numberOfAdults ?? this.numberOfAdults,
    numberOfChildren: numberOfChildren ?? this.numberOfChildren,
    housingType: housingType ?? this.housingType,
    isOwner: isOwner ?? this.isOwner,
    area: area ?? this.area,
    over15Years: over15Years ?? this.over15Years,
    energyPerformance: energyPerformance ?? this.energyPerformance,
    isPrmPresent: isPrmPresent ?? this.isPrmPresent,
    isPrmObsolete: isPrmObsolete ?? this.isPrmObsolete,
    isAddressComplete: isAddressComplete ?? this.isAddressComplete,
  );

  @override
  List<Object?> get props => [
    address,
    numberOfAdults,
    numberOfChildren,
    housingType,
    isOwner,
    area,
    over15Years,
    energyPerformance,
    isPrmPresent,
    isPrmObsolete,
    isAddressComplete,
  ];
}
