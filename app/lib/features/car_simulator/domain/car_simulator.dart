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

/// NOTE: For now, there is only car alternatives, however, we should be
class CarSimulatorOption extends CarInfos {
  const CarSimulatorOption({
    required super.cost,
    required super.emissions,
    required super.size,
    required super.motorisation,
    required super.fuel,
    required this.type,
  });

  final CarOptionType type;
}

class BestCostCarSimulatorOption {
  const BestCostCarSimulatorOption({required this.carOption, required this.diffWithCurrentCar});

  final CarSimulatorOption carOption;
  final double diffWithCurrentCar;
}

class BestEmissionCarSimulatorOption {
  const BestEmissionCarSimulatorOption({required this.carOption, required this.percentDiffWithCurrentCar});

  final CarSimulatorOption carOption;
  final double percentDiffWithCurrentCar;
}

enum CarOptionType { car }

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
  utilityVehicle,
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
