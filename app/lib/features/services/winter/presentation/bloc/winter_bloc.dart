import 'dart:async';

import 'package:app/core/presentation/widgets/composants/address/user_address_repository.dart';
import 'package:app/features/profil/core/infrastructure/profil_repository.dart';
import 'package:app/features/services/winter/domain/winter_registration.dart';
import 'package:app/features/services/winter/infrastructure/winter_repository.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_event.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WinterBloc extends Bloc<WinterEvent, WinterState> {
  WinterBloc(this._repository, this._userAddressRepository, this._profilRepository) : super(const WinterLoading()) {
    on<WinterActionIsDone>(_onActionIsDone);
    on<WinterStarted>(_onStarted);
    on<WinterFormTypeChanged>(_onFormTypeChanged);
    on<WinterAddressChanged>(_onAddressChanged);
    on<WinterLastNameChanged>(_onLastNameChanged);
    on<WinterPrmNumberChanged>(_onPrmNumberChanged);
    on<WinterDeclarationChanged>(_onDeclarationChanged);
    on<WinterSubmit>(_onSubmit);
    on<WinterConnectionStatusReset>(_onConnectionStatusReset);
    on<WinterStartQuestions>(_onStartQuestions);
    on<WinterQuestionsFinished>(_onQuestionsFinished);
    on<WinterRestart>(_onRestart);
  }

  final WinterRepository _repository;
  final UserAddressRepository _userAddressRepository;
  final ProfilRepository _profilRepository;

  Future<void> _onActionIsDone(final WinterActionIsDone event, final Emitter<WinterState> emit) async {
    if (!event.isDone) {
      emit(const WinterInitial());

      return;
    }

    final home = await _profilRepository.getHome();
    if (!home.isPrmPresent || home.isPrmObsolete || !home.isAddressComplete) {
      emit(const WinterInitial());

      return;
    }

    final consumptionResult = await _repository.getConsumption();
    final numberOfActionsResult = await _repository.getNumberOfActions();
    consumptionResult.fold((final l) {}, (final consumption) {
      numberOfActionsResult.fold(
        (final l) {},
        (final numberOfActions) => emit(WinterMyConsumption(data: consumption, numberOfActions: numberOfActions)),
      );
    });
  }

  Future<void> _onStarted(final WinterStarted event, final Emitter<WinterState> emit) async {
    final addressResult = await _userAddressRepository.fetchAddress();
    addressResult.fold((final l) {}, (final address) {
      emit(
        WinterForm(
          formType: RegistrationType.address,
          address: address.isFull ? address : null,
          isAddressCompleted: address.isFull,
          lastName: '',
          prmNumber: '',
          isDeclarationChecked: false,
          connectionStatus: WinterConnectionStatus.unknown,
        ),
      );
    });
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
    final state = this.state;

    if (state is! WinterForm || state.isFormInvalid) {
      return;
    }

    emit(state.copyWith(connectionStatus: WinterConnectionStatus.loading));

    final registrationDetails = switch (state.formType) {
      RegistrationType.address => WinterRegistrationByAddress(lastName: state.lastName, address: state.address!),
      RegistrationType.prm => WinterRegistrationByPrm(lastName: state.lastName, prmNumber: state.prmNumber),
    };

    final result = await _repository.register(registrationDetails);
    final connectionStatus = result.fold(
      (final l) => WinterConnectionStatus.failed,
      (final r) => WinterConnectionStatus.established,
    );
    emit(state.copyWith(connectionStatus: connectionStatus));
  }

  void _onConnectionStatusReset(final WinterConnectionStatusReset event, final Emitter<WinterState> emit) {
    final currentState = state;
    if (currentState is WinterForm) {
      emit(currentState.copyWith(connectionStatus: WinterConnectionStatus.unknown));
    }
  }

  void _onStartQuestions(final WinterStartQuestions event, final Emitter<WinterState> emit) {
    final currentState = state;
    if (currentState is WinterForm) {
      emit(const WinterQuestionsState());
    }
  }

  Future<void> _onQuestionsFinished(final WinterQuestionsFinished event, final Emitter<WinterState> emit) async {
    final currentState = state;
    if (currentState is WinterQuestionsState) {
      final consumptionResult = await _repository.getConsumption();
      final numberOfActionsResult = await _repository.getNumberOfActions();
      consumptionResult.fold((final l) {}, (final consumption) {
        numberOfActionsResult.fold(
          (final l) {},
          (final numberOfActions) => emit(WinterMyConsumption(data: consumption, numberOfActions: numberOfActions)),
        );
      });
    }
  }

  void _onRestart(final WinterRestart event, final Emitter<WinterState> emit) {
    emit(const WinterInitial());
  }
}
