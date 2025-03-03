import 'package:app/features/car_simulator/domain/car_simulator.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class CarSimulatorState extends Equatable {
  const CarSimulatorState();

  @override
  List<Object?> get props => [];
}

@immutable
final class CarSimulatorLoading extends CarSimulatorState {
  const CarSimulatorLoading();
}

@immutable
final class CarSimulatorGetCurrentCarSuccess extends CarSimulatorState {
  const CarSimulatorGetCurrentCarSuccess({required this.currentCar});

  final CarInfos currentCar;

  @override
  List<Object?> get props => [currentCar];
}

@immutable
final class CarSimulatorGetCarOptionsSuccess extends CarSimulatorState {
  const CarSimulatorGetCarOptionsSuccess({
    required this.currentCar,
    required this.carOptions,
    required this.selectedSize,
    required this.hasChargingStation,
    required this.bestCostOption,
    required this.bestEmissionOption,
  });

  final CarInfos currentCar;
  final List<CarSimulatorOption> carOptions;
  final CarSize selectedSize;
  final bool hasChargingStation;
  final CarSimulatorOption bestCostOption;
  final CarSimulatorOption bestEmissionOption;

  @override
  List<Object?> get props => [currentCar, carOptions, selectedSize, hasChargingStation, bestCostOption, bestEmissionOption];
}

@immutable
final class CarSimulatorLoadFailure extends CarSimulatorState {
  const CarSimulatorLoadFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
