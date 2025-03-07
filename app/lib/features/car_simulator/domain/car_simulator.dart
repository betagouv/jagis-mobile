import 'package:equatable/equatable.dart';

class CarInfos extends Equatable {
  const CarInfos({
    required this.cost,
    required this.emissions,
    required this.size,
    required this.motorisation,
    required this.fuel,
  });

  final double cost;
  final double emissions;
  final ComputedValue<CarSize> size;
  final ComputedValue<CarMotorisation> motorisation;
  final ComputedValue<CarFuel>? fuel;

  @override
  List<Object?> get props => [cost, emissions, size, motorisation, fuel];
}

// TODO(erolley): For now, there is only car alternatives, however, we should be able to add other types of alternatives in the future.
class CarSimulatorOption extends CarInfos {
  const CarSimulatorOption({
    required super.cost,
    required super.emissions,
    required super.size,
    required super.motorisation,
    required super.fuel,
    required this.title,
  });

  final String title;
}

enum CarSize {
  /// Petite voiture
  small,

  /// Moyenne voiture
  medium,

  /// Berline
  sedan,

  /// Sport Utility Vehicle (SUV)
  suv,

  /// Véhicule Utilitaire Léger (VUL)
  utilityVehicle;

  CarSize get smaller => switch (this) {
    utilityVehicle => suv,
    suv => sedan,
    sedan => medium,
    medium || small => small,
  };
}

enum CarMotorisation { thermal, hybrid, electric }

enum CarFuel {
  /// Essence (E5 ou E10)
  gasoline,

  /// Essence E85
  gasolineE85,

  /// Diesel
  diesel,

  /// Gaz de Pétrole Liquéfié (GPL)
  lpg,
}

/// A computed value is a raw [value] used to compute purpose and a [label] to display.
///
/// ```dart
/// ComputedValue<CarSize>(value: CarSize.small, label: 'Petite voiture');
/// ```
class ComputedValue<V> extends Equatable {
  const ComputedValue({required this.value, required this.label});

  final V value;
  final String label;

  @override
  List<Object?> get props => [value, label];
}

enum CarSimulatorOptionKind { bestCost, bestEmission }
