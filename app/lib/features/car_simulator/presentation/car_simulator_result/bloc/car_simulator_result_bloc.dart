// ignore_for_file: prefer-typedefs-for-callbacks

import 'dart:async';

import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/infrastructure/action_repository.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/car_simulator/domain/car_simulator.dart';
import 'package:app/features/car_simulator/infrastructure/car_simulator_repository.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/bloc/car_simulator_result_event.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/bloc/car_simulator_result_state.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class CarSimulatorResultBloc extends Bloc<CarSimulatorResultEvent, CarSimulatorResultState> {
  CarSimulatorResultBloc({
    required final CarSimulatorRepository carSimulatorRepository,
    required final ActionRepository actionRepository,
  }) : _carSimulatorRepository = carSimulatorRepository,
       _actionRepository = actionRepository,
       super(const CarSimulatorInit()) {
    on<CarSimulatorActionMarkAsDone>((final event, final emit) async {
      await _actionRepository.markAsDone(
        type: ActionType.simulator,
        id: actionSimulatorIdToAPIString(ActionSimulatorId.carSimulator),
      );
    });
    on<CarSimulatorGetCurrentCarResult>(_onGetCurrentCarResult);
    on<CarSimulatorNewSelectedCarSize>(_onNewSelectedCarSize);
    on<CarSimulatorToggleChargingStation>(_onToggleChargingStation);
  }

  final CarSimulatorRepository _carSimulatorRepository;
  final ActionRepository _actionRepository;

  Future<void> _onGetCurrentCarResult(
    final CarSimulatorGetCurrentCarResult event,
    final Emitter<CarSimulatorResultState> emit,
  ) async {
    final result = await _carSimulatorRepository.computeCurrentCar();
    if (result.isRight()) {
      final currentCar = result.getRight().getOrElse(() => throw Exception());

      emit(CarSimulatorGetCurrentCarSuccess(currentCar: currentCar));

      final result2 = await _carSimulatorRepository.computeCarSimulatorOptions();
      if (result2.isRight()) {
        final carOptions = result2.getRight().getOrElse(() => throw Exception());

        emit(_getCarOptionsSuccessState(currentCar: currentCar, carOptions: carOptions, hasChargingStation: true));
      } else {
        emit(CarSimulatorLoadFailure(result2.getLeft().toString()));
      }
    } else {
      emit(CarSimulatorLoadFailure(result.getLeft().toString()));
    }
  }

  void _onNewSelectedCarSize(final CarSimulatorNewSelectedCarSize event, final Emitter<CarSimulatorResultState> emit) {
    final blocState = state;

    if (blocState is CarSimulatorGetCarOptionsSuccess) {
      emit(
        _getCarOptionsSuccessState(
          currentCar: blocState.currentCar,
          carOptions: blocState.carOptions,
          hasChargingStation: blocState.hasChargingStation,
          carSize: event.carSize,
        ),
      );
    }
  }

  void _onToggleChargingStation(final CarSimulatorToggleChargingStation event, final Emitter<CarSimulatorResultState> emit) {
    final blocState = state;

    if (blocState is CarSimulatorGetCarOptionsSuccess) {
      emit(
        _getCarOptionsSuccessState(
          currentCar: blocState.currentCar,
          carOptions: blocState.carOptions,
          hasChargingStation: event.hasChargingStation,
          carSize: blocState.selectedSize,
        ),
      );
    }
  }

  CarSimulatorGetCarOptionsSuccess _getCarOptionsSuccessState({
    required final CarInfos currentCar,
    required final List<CarSimulatorOption> carOptions,
    required final bool hasChargingStation,
    final CarSize? carSize,
  }) {
    final selectedSize = carSize ?? currentCar.size.value.smaller;
    final bestCostOption = _getBestOption(carOptions, selectedSize, hasChargingStation, (final option) => option.cost);
    final bestEmissionOption = _getBestOption(carOptions, selectedSize, hasChargingStation, (final option) => option.emissions);

    return CarSimulatorGetCarOptionsSuccess(
      currentCar: currentCar,
      carOptions: carOptions,
      selectedSize: selectedSize,
      hasChargingStation: hasChargingStation,
      bestCostOption: bestCostOption,
      bestEmissionOption: bestEmissionOption,
    );
  }

  CarSimulatorOption _getBestOption(
    final List<CarSimulatorOption> carOptions,
    final CarSize selectedSize,
    final bool hasChargingStation,
    final double Function(CarSimulatorOption option) comparator,
  ) =>
      carOptions
          .filter(
            (final option) =>
                option.size.value == selectedSize &&
                (hasChargingStation || option.motorisation.value != CarMotorisation.electric),
          )
          .sorted((final a, final b) => comparator(a).compareTo(comparator(b)))
          .first;
}
