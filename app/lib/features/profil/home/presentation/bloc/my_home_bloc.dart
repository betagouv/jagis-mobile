import 'dart:async';

import 'package:app/core/address/address.dart';
import 'package:app/features/communes/infrastructure/communes_repository.dart';
import 'package:app/features/profil/core/infrastructure/profil_repository.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_event.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomeBloc extends Bloc<MyHomeEvent, MyHomeState> {
  MyHomeBloc(this._profilRepository, this._communesRepository) : super(const MyHomeLoadInProgress()) {
    on<MyHomeLoadRequested>(_onLoadRequested);
    on<MyHomeCodePostalChange>(_onCodePostalChange);
    on<MyHomeDataUpdated>(_onDataUpdated);
    on<MyHomeAddressDeletePressed>(_onAddressDeletePressed);
    on<MyHomeUpdateRequested>(_onUpdateRequested);
  }

  final ProfilRepository _profilRepository;
  final CommunesRepository _communesRepository;

  Future<void> _onLoadRequested(final MyHomeLoadRequested event, final Emitter<MyHomeState> emit) async {
    emit(const MyHomeLoadInProgress());
    try {
      final home = await _profilRepository.getHome();
      final postCode = home.address.postCode;
      final municipalities = await _communesRepository.recupererLesCommunes(postCode);
      emit(MyHomeLoadSuccess(logement: home, municipalities: municipalities));
    } on Exception {
      emit(const MyHomeLoadFailure());
    }
  }

  Future<void> _onCodePostalChange(final MyHomeCodePostalChange event, final Emitter<MyHomeState> emit) async {
    final state = this.state;
    if (state is MyHomeLoadSuccess) {
      try {
        final municipalities = event.valeur.length == 5
            ? await _communesRepository.recupererLesCommunes(event.valeur)
            : <Commune>[];
        final newAddress = state.logement.address.copyWith(
          postCode: event.valeur,
          municipality: municipalities.length == 1 ? municipalities.first.label : '',
        );
        emit(
          MyHomeLoadSuccess(
            logement: state.logement.copyWith(address: newAddress),
            municipalities: municipalities,
          ),
        );
      } on Exception {
        emit(const MyHomeLoadFailure());
      }
    }
  }

  void _onDataUpdated(final MyHomeDataUpdated event, final Emitter<MyHomeState> emit) {
    final state = this.state;
    if (state is MyHomeLoadSuccess) {
      emit(
        state.copyWith(
          logement: state.logement.copyWith(
            address: state.logement.address.copyWith(
              latitude: event.latitude,
              longitude: event.longitude,
              houseNumber: event.houseNumber,
              street: event.street,
              postCode: event.postCode,
              municipality: event.municipality,
              cityCode: event.cityCode,
            ),
            numberOfAdults: event.numberOfAdults,
            numberOfChildren: event.numberOfChildren,
            housingType: event.housingType,
            isOwner: event.isOwner,
            area: event.area,
            over15Years: event.over15Years,
            energyPerformance: event.energyPerformance,
          ),
        ),
      );
    }
  }

  Future<void> _onAddressDeletePressed(final MyHomeAddressDeletePressed event, final Emitter<MyHomeState> emit) async {
    final state = this.state;
    if (state is MyHomeLoadSuccess) {
      try {
        await _profilRepository.deleteAddress();
        final address = state.logement.address;
        final newAddress = Address(
          latitude: null,
          longitude: null,
          houseNumber: null,
          street: null,
          postCode: address.postCode,
          municipality: address.municipality,
          cityCode: address.cityCode,
        );
        emit(state.updateAddress(newAddress));
      } on Exception {
        emit(const MyHomeLoadFailure());
      }
    }
  }

  Future<void> _onUpdateRequested(final MyHomeUpdateRequested event, final Emitter<MyHomeState> emit) async {
    final state = this.state;
    if (state is MyHomeLoadSuccess) {
      try {
        await _profilRepository.updateHome(state.logement);
      } on Exception {
        emit(const MyHomeLoadFailure());
      }
    }
  }
}
