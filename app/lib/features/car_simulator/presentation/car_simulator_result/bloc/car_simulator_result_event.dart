import 'package:app/features/car_simulator/domain/car_simulator.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class CarSimulatorResultEvent extends Equatable {
  const CarSimulatorResultEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class CarSimulatorGetCurrentCarResult extends CarSimulatorResultEvent {
  const CarSimulatorGetCurrentCarResult();
}

@immutable
final class CarSimulatorNewSelectedCarSize extends CarSimulatorResultEvent {
  const CarSimulatorNewSelectedCarSize(this.carSize);

  final CarSize carSize;

  @override
  List<Object> get props => [carSize];
}

@immutable
final class CarSimulatorToggleChargingStation extends CarSimulatorResultEvent {
  const CarSimulatorToggleChargingStation(this.hasChargingStation);

  final bool hasChargingStation;

  @override
  List<Object> get props => [hasChargingStation];
}
