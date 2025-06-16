import 'dart:async';

import 'package:app/core/presentation/widgets/composants/address/bloc/address_event.dart';
import 'package:app/core/presentation/widgets/composants/address/bloc/address_state.dart';
import 'package:app/core/presentation/widgets/composants/address/user_address_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc(this._repository) : super(const AddressState(AddressStatus.initial, null, null)) {
    on<AddressFetchRequested>(_fetchRequested);
    on<AddressSelected>(_selected);
    on<AddressSaveRequested>(_saveRequested);
  }

  final UserAddressRepository _repository;

  Future<void> _fetchRequested(final AddressFetchRequested event, final Emitter<AddressState> emit) async {
    final result = await _repository.fetchAddress();
    final address = result.fold((final l) => null, (final r) => r);
    emit(AddressState(AddressStatus.loaded, address, address));
  }

  void _selected(final AddressSelected event, final Emitter<AddressState> emit) {
    emit(AddressState(AddressStatus.loaded, state.address, event.address));
  }

  Future<void> _saveRequested(final AddressSaveRequested event, final Emitter<AddressState> emit) async {
    final selectedAddress = state.selectedAddress;
    if (selectedAddress == null) {
      return;
    }
    await _repository.modifyAddress(selectedAddress);
    emit(AddressState(AddressStatus.loaded, selectedAddress, selectedAddress));
  }
}
