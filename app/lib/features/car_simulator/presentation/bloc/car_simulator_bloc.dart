import 'dart:async';

import 'package:app/features/car_simulator/domain/car_simulator.dart';
import 'package:app/features/car_simulator/infrastructure/car_simulator_repository.dart';
import 'package:app/features/car_simulator/presentation/bloc/car_simulator_event.dart';
import 'package:app/features/car_simulator/presentation/bloc/car_simulator_state.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class CarSimulatorBloc extends Bloc<CarSimulatorEvent, CarSimulatorState> {
  CarSimulatorBloc({required final CarSimulatorRepository repository})
    : _carSimulatorRepository = repository,
      super(const CarSimulatorLoading()) {
    on<CarSimulatorGetCurrentCarResult>(_onGetCurrentCarResult);
    on<CarSimulatorNewSelectedCarSize>(_onNewSelectedCarSize);
  }

  final CarSimulatorRepository _carSimulatorRepository;

  Future<void> _onGetCurrentCarResult(final CarSimulatorGetCurrentCarResult event, final Emitter<CarSimulatorState> emit) async {
    final result = await _carSimulatorRepository.computeCurrentCar();
    if (result.isRight()) {
      final currentCar = result.getRight().getOrElse(() => throw Exception());
      final selectedSize = currentCar.size.value;

      emit(CarSimulatorGetCurrentCarSuccess(currentCar: currentCar));

      final result2 = await _carSimulatorRepository.computeCarSimulatorOptions();
      if (result2.isRight()) {
        final carOptions = result2.getRight().getOrElse(() => throw Exception());
        final bestCostOption = _getBestOption(carOptions, selectedSize, (final option) => option.cost);
        final bestEmissionOption = _getBestOption(carOptions, selectedSize, (final option) => option.emissions);

        emit(
          CarSimulatorGetCarOptionsSuccess(
            currentCar: currentCar,
            selectedSize: selectedSize,
            bestCostOption: bestCostOption,
            bestEmissionOption: bestEmissionOption,
          ),
        );
      } else {
        emit(CarSimulatorLoadFailure(result2.getLeft().toString()));
      }
    } else {
      emit(CarSimulatorLoadFailure(result.getLeft().toString()));
    }
  }

  Future<void> _onNewSelectedCarSize(final CarSimulatorNewSelectedCarSize event, final Emitter<CarSimulatorState> emit) async {
    final result = await _carSimulatorRepository.computeCarSimulatorOptions();
    final stateWithCurrentCar = state;
    final selectedSize = event.carSize;

    if (result.isRight() && stateWithCurrentCar is CarSimulatorGetCarOptionsSuccess) {
      final currentCar = stateWithCurrentCar.currentCar;
      final carOptions = result.getRight().getOrElse(() => throw Exception());
      final bestCostOption = _getBestOption(carOptions, selectedSize, (final option) => option.cost);
      final bestEmissionOption = _getBestOption(carOptions, selectedSize, (final option) => option.emissions);

      emit(
        CarSimulatorGetCarOptionsSuccess(
          currentCar: currentCar,
          selectedSize: selectedSize,
          bestCostOption: bestCostOption,
          bestEmissionOption: bestEmissionOption,
        ),
      );
    } else {
      emit(CarSimulatorLoadFailure(result.getLeft().toString()));
    }
  }

  CarSimulatorOption _getBestOption(
    final List<CarSimulatorOption> carOptions,
    final CarSize selectedSize,
    final double Function(CarSimulatorOption) comparator,
  ) =>
      carOptions.sorted((final a, final b) {
        if (a.size.value != selectedSize && b.size.value == selectedSize) {
          return 1;
        }
        if (a.size.value == selectedSize && b.size.value != selectedSize) {
          return -1;
        }
        return comparator(a).compareTo(comparator(b));
      })[0];
}
