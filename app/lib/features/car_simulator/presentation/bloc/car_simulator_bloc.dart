import 'dart:async';

import 'package:app/features/car_simulator/infrastructure/car_simulator_repository.dart';
import 'package:app/features/car_simulator/presentation/bloc/car_simulator_event.dart';
import 'package:app/features/car_simulator/presentation/bloc/car_simulator_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class CarSimulatorBloc extends Bloc<CarSimulatorEvent, CarSimulatorState> {
  CarSimulatorBloc({required final CarSimulatorRepository repository})
    : _carSimulatorRepository = repository,
      super(const CarSimulatorLoading()) {
    on<CarSimulatorGetOptions>(_onGetOptions);
    on<CarSimulatorGetCurrentCarResult>(_onGetCurrentCarResult);
  }

  // final ProfilRepository _profilRepository;
  final CarSimulatorRepository _carSimulatorRepository;

  Future<void> _onGetCurrentCarResult(final CarSimulatorGetCurrentCarResult event, final Emitter<CarSimulatorState> emit) async {
    final result = await _carSimulatorRepository.computeCurrentCar();
    if (result.isRight()) {
      final currentCar = result.getRight().getOrElse(() => throw Exception());

      emit(CarSimulatorSuccess(currentCar: currentCar));
    } else {
      emit(CarSimulatorLoadFailure(result.getLeft().toString()));
    }
  }

  Future<void> _onGetOptions(final CarSimulatorGetOptions event, final Emitter<CarSimulatorState> emit) async {
    final result = await _carSimulatorRepository.computeCarSimulatorOptions();
    if (result.isRight()) {
      final options = result.getRight().getOrElse(() => throw Exception());

      emit(CarSimulatorSuccess(currentCar: event.currentCar, options: options));
    } else {
      emit(CarSimulatorLoadFailure(result.getLeft().toString()));
    }
  }
}
