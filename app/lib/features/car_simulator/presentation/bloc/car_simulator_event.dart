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
final class CarSimulatorGetOptions extends CarSimulatorEvent {
  const CarSimulatorGetOptions(this.currentCar);

  final CarInfos currentCar;

  @override
  List<Object> get props => [currentCar];
}
