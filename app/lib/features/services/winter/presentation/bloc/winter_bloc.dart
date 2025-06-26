import 'dart:async';

import 'package:app/core/address/address.dart';
import 'package:app/features/services/winter/domain/winter_registration.dart';
import 'package:app/features/services/winter/infrastructure/winter_repository.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_event.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WinterBloc extends Bloc<WinterEvent, WinterState> {
  WinterBloc(this._repository) : super(const WinterInitial()) {
    on<WinterStarted>(_onStarted);
    on<WinterFormTypeChanged>(_onFormTypeChanged);
    on<WinterAddressChanged>(_onAddressChanged);
    on<WinterLastNameChanged>(_onLastNameChanged);
    on<WinterPrmNumberChanged>(_onPrmNumberChanged);
    on<WinterDeclarationChanged>(_onDeclarationChanged);
    on<WinterSubmit>(_onSubmit);
    on<WinterConnectionStatusReset>(_onConnectionStatusReset);
  }

  final WinterRepository _repository;

  void _onStarted(final WinterStarted event, final Emitter<WinterState> emit) {
    emit(
      const WinterForm(
        formType: RegistrationType.address,
        address: Address(latitude: null, longitude: null, houseNumber: '', street: '', postCode: '', city: '', cityCode: ''),
        lastName: '',
        prmNumber: '',
        isDeclarationChecked: false,
        connectionStatus: WinterConnectionStatus.unknown,
      ),
    );
  }

  void _onFormTypeChanged(final WinterFormTypeChanged event, final Emitter<WinterState> emit) {
    final currentState = state;
    if (currentState is WinterForm) {
      emit(currentState.copyWith(formType: event.value));
    }
  }

  void _onAddressChanged(final WinterAddressChanged event, final Emitter<WinterState> emit) {
    final currentState = state;
    if (currentState is WinterForm) {
      emit(currentState.copyWith(address: event.value));
    }
  }

  void _onLastNameChanged(final WinterLastNameChanged event, final Emitter<WinterState> emit) {
    final currentState = state;
    if (currentState is WinterForm) {
      emit(currentState.copyWith(lastName: event.value));
    }
  }

  void _onPrmNumberChanged(final WinterPrmNumberChanged event, final Emitter<WinterState> emit) {
    final currentState = state;
    if (currentState is WinterForm) {
      emit(currentState.copyWith(prmNumber: event.value));
    }
  }

  void _onDeclarationChanged(final WinterDeclarationChanged event, final Emitter<WinterState> emit) {
    final currentState = state;
    if (currentState is WinterForm) {
      emit(currentState.copyWith(isDeclarationChecked: event.value));
    }
  }

  Future<void> _onSubmit(final WinterSubmit event, final Emitter<WinterState> emit) async {
    final currentState = state;

    if (currentState is! WinterForm || currentState.isFormInvalid) {
      return;
    }

    final registration = WinterRegistration(
      type: switch (currentState.formType) {
        RegistrationType.address => RegistrationType.address,
        RegistrationType.prm => RegistrationType.prm,
      },
      lastName: currentState.lastName,
      address: currentState.formType == RegistrationType.address ? currentState.address : null,
      prmNumber: currentState.formType == RegistrationType.prm ? currentState.prmNumber : null,
    );

    final result = await _repository.register(registration);

    final connectionStatus = result.fold(
      (final l) => WinterConnectionStatus.failed,
      (final r) => WinterConnectionStatus.established,
    );
    emit(currentState.copyWith(connectionStatus: connectionStatus));
  }

  void _onConnectionStatusReset(final WinterConnectionStatusReset event, final Emitter<WinterState> emit) {
    final currentState = state;
    if (currentState is WinterForm) {
      emit(currentState.copyWith(connectionStatus: WinterConnectionStatus.unknown));
    }
  }
}
