import 'package:app/core/address/address.dart';
import 'package:app/features/services/maif/domain/fetch_risk_info_for_address.dart';
import 'package:app/features/services/maif/domain/modify_address.dart';
import 'package:app/features/services/maif/infrastructure/maif_repository.dart';
import 'package:app/features/services/maif/presentation/bloc/maif_event.dart';
import 'package:app/features/services/maif/presentation/bloc/maif_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaifBloc extends Bloc<MaifEvent, MaifState> {
  MaifBloc(
    final MaifRepository repository,
    final FetchRiskInfoForAddress fetchRiskInfoForAddress,
    final ModifyAddress updateAddress,
  ) : super(const MaifInitial()) {
    on<MaifLoadRequested>((final event, final emit) async {
      emit(const MaifLoadInProgress());
      final result = await repository.fetch();

      await result.fold((final failure) async => emit(const MaifLoadFailure()), (final data) async {
        final address = Address(
          latitude: data.latitude,
          longitude: data.longitude,
          houseNumber: data.houseNumber,
          street: data.street,
          postCode: data.postCode,
          city: data.city,
          cityCode: data.cityCode,
        );
        final initialState = MaifLoadSuccess(
          userAddress: address,
          searchAddress: address,
          risks: const [],
          numberOfCatNat: data.numberOfCatNat,
          droughtPercentage: data.droughtPercentage,
          floodPercentage: data.floodPercentage,
        );

        if (!initialState.searchAddress.isFull) {
          emit(initialState);

          return;
        }

        final scoreResult = await fetchRiskInfoForAddress.run(initialState.searchAddress);
        scoreResult.fold((final failure) => emit(const MaifLoadFailure()), (final risks) {
          emit(initialState.copyWith(risks: risks));
        });
      });
    });
    on<MaifAddressChanged>((final event, final emit) async {
      final currentState = state;
      if (currentState is! MaifLoadSuccess) {
        return;
      }
      final address = event.value;
      final result = await fetchRiskInfoForAddress.run(address);
      final cityCode = address.cityCode;
      final catNatResult = await repository.fetchCatNat(cityCode);
      final droughtResult = await repository.fetchDroughtPercentage(cityCode);
      final floodResult = await repository.fetchFloodPercentage(cityCode);
      result.fold((final failure) => emit(const MaifLoadFailure()), (final risks) {
        catNatResult.fold((final failure) => emit(const MaifLoadFailure()), (final numberOfCatNat) {
          droughtResult.fold((final failure) => emit(const MaifLoadFailure()), (final droughtPercentage) {
            floodResult.fold((final failure) => emit(const MaifLoadFailure()), (final floodPercentage) {
              emit(
                currentState.copyWith(
                  searchAddress: address,
                  risks: risks,
                  numberOfCatNat: numberOfCatNat,
                  droughtPercentage: droughtPercentage,
                  floodPercentage: floodPercentage,
                ),
              );
            });
          });
        });
      });
    });
    on<MaifNewAddressChosen>((final event, final emit) async {
      final currentState = state;
      if (currentState is! MaifLoadSuccess) {
        return;
      }
      final address = event.value;
      await updateAddress.run(address);
      emit(currentState.copyWith(userAddress: address));
    });
  }
}
