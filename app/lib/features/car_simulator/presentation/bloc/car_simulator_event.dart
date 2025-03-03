import 'package:app/features/car_simulator/domain/car_simulator.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class CarSimulatorEvent extends Equatable {
  const CarSimulatorEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class CarSimulatorGetCurrentCarResult extends CarSimulatorEvent {
  const CarSimulatorGetCurrentCarResult();
}

@immutable
final class CarSimulatorNewSelectedCarSize extends CarSimulatorEvent {
  const CarSimulatorNewSelectedCarSize(this.carSize);

  final CarSize carSize;

  @override
  List<Object> get props => [carSize];
}

@immutable
final class CarSimulatorToggleChargingStation extends CarSimulatorEvent {
  const CarSimulatorToggleChargingStation(this.hasChargingStation);

  final bool hasChargingStation;

  @override
  List<Object> get props => [hasChargingStation];
}
