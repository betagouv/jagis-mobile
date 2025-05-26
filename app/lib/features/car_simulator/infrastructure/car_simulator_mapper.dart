import 'package:app/features/car_simulator/domain/car_simulator.dart';

abstract final class CarInfosMapper {
  static CarInfos fromJson(final Map<String, dynamic> json) => CarInfos(
    cost: json['couts'] as double,
    emissions: json['empreinte'] as double,
    size: ComputedValueMapper.fromJson(json['gabarit'] as Map<String, dynamic>, CarSizeMapper.fromJson),
    motorisation: ComputedValueMapper.fromJson(json['motorisation'] as Map<String, dynamic>, CarMotorisationMapper.fromJson),
    fuel: json['carburant'] == null
        ? null
        : ComputedValueMapper.fromJson(json['carburant'] as Map<String, dynamic>, CarFuelMapper.fromJson),
  );
}

abstract final class CarSimulatorOptionMapper {
  static CarSimulatorOption fromJson(final dynamic json) {
    final carInfos = CarInfosMapper.fromJson(json as Map<String, dynamic>);

    // TODO(erolley): for the moment, there is only one alternative, but we should be able to handle more than one.
    return CarSimulatorOption(
      cost: carInfos.cost,
      emissions: carInfos.emissions,
      size: carInfos.size,
      motorisation: carInfos.motorisation,
      fuel: carInfos.fuel,
      title: json['titre'] as String,
    );
  }
}

abstract final class ComputedValueMapper {
  static ComputedValue<V> fromJson<V>(final Map<String, dynamic> json, final V Function(String value) valueToJson) =>
      ComputedValue(value: valueToJson(json['valeur'] as String), label: json['label'] as String);
}

abstract final class CarSizeMapper {
  static CarSize fromJson(final String json) => switch (json) {
    'petite' => CarSize.small,
    'moyenne' => CarSize.medium,
    'berline' => CarSize.sedan,
    'SUV' => CarSize.suv,
    'VUL' => CarSize.utilityVehicle,
    _ => throw Exception('Unknown CarSize: $json'),
  };
}

abstract final class CarMotorisationMapper {
  static CarMotorisation fromJson(final String json) => switch (json) {
    'thermique' => CarMotorisation.thermal,
    'hybride' => CarMotorisation.hybrid,
    'électrique' => CarMotorisation.electric,
    _ => throw Exception('Unknown CarMotorisation: $json'),
  };
}

abstract final class CarFuelMapper {
  static CarFuel fromJson(final String json) => switch (json) {
    'essence E5 ou E10' => CarFuel.gasoline,
    'essence E85' => CarFuel.gasolineE85,
    'gazole B7 ou B10' => CarFuel.diesel,
    'GPL' => CarFuel.lpg,
    _ => throw Exception('Unknown CarFuel: $json'),
  };
}
