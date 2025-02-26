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
final class CarSimulatorSuccess extends CarSimulatorState {
  const CarSimulatorSuccess({required this.currentCar, this.options});

  final CarInfos currentCar;
  final List<CarSimulatorOption>? options;

  /// TODO(erolley): how to handle [options] here?
  @override
  List<Object?> get props => [currentCar, options];
}

@immutable
final class CarSimulatorLoadFailure extends CarSimulatorState {
  const CarSimulatorLoadFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
