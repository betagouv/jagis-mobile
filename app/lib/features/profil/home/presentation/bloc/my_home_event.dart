import 'package:app/features/profil/home/domain/area.dart';
import 'package:app/features/profil/home/domain/energy_performance.dart';
import 'package:app/features/profil/home/domain/type_de_logement.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class MyHomeEvent extends Equatable {
  const MyHomeEvent();

  @override
  List<Object?> get props => [];
}

@immutable
final class MyHomeLoadRequested extends MyHomeEvent {
  const MyHomeLoadRequested();
}

@immutable
final class MyHomeCodePostalChange extends MyHomeEvent {
  const MyHomeCodePostalChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class MyHomeDataUpdated extends MyHomeEvent {
  const MyHomeDataUpdated({
    this.latitude,
    this.longitude,
    this.houseNumber,
    this.street,
    this.postCode,
    this.cityCode,
    this.municipality,
    this.numberOfAdults,
    this.numberOfChildren,
    this.housingType,
    this.isOwner,
    this.area,
    this.over15Years,
    this.energyPerformance,
  });

  final double? latitude;
  final double? longitude;
  final String? houseNumber;
  final String? street;
  final String? postCode;
  final String? municipality;
  final String? cityCode;
  final int? numberOfAdults;
  final int? numberOfChildren;
  final TypeDeLogement? housingType;
  final bool? isOwner;
  final Area? area;
  final bool? over15Years;
  final EnergyPerformance? energyPerformance;

  @override
  List<Object?> get props => [
    latitude,
    longitude,
    houseNumber,
    street,
    postCode,
    municipality,
    numberOfAdults,
    numberOfChildren,
    housingType,
    isOwner,
    area,
    over15Years,
    energyPerformance,
    cityCode,
  ];
}

@immutable
final class MyHomeAddressDeletePressed extends MyHomeEvent {
  const MyHomeAddressDeletePressed();
}

@immutable
final class MyHomeUpdateRequested extends MyHomeEvent {
  const MyHomeUpdateRequested();
}
