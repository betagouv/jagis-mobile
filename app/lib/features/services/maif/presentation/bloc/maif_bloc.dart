import 'package:app/core/presentation/widgets/composants/address/user_address_repository.dart';
import 'package:app/features/services/maif/domain/fetch_risk_info_for_address.dart';
import 'package:app/features/services/maif/infrastructure/maif_repository.dart';
import 'package:app/features/services/maif/presentation/bloc/maif_event.dart';
import 'package:app/features/services/maif/presentation/bloc/maif_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaifBloc extends Bloc<MaifEvent, MaifState> {
  MaifBloc(
    final UserAddressRepository userAddressRepository,
    final MaifRepository repository,
    final FetchRiskInfoForAddress fetchRiskInfoForAddress,
  ) : super(const MaifInitial()) {
    on<MaifLoadRequested>((final event, final emit) async {
      emit(const MaifLoadInProgress());
      final addressResult = await userAddressRepository.fetchAddress();
      await addressResult.fold((final failure) async => emit(const MaifLoadFailure()), (final address) async {
        final cityRiskResult = await repository.fetchCityRisk(address.cityCode);
        await cityRiskResult.fold((final failure) async => emit(const MaifLoadFailure()), (final cityRisk) async {
          final initialState = MaifLoadSuccess(
            userAddress: address,
            searchAddress: address,
            risks: const [],
            numberOfCatNat: cityRisk.numberOfCatNat,
            droughtPercentage: cityRisk.droughtPercentage,
            floodPercentage: cityRisk.floodPercentage,
            isLoading: false,
          );

          if (!address.isFull) {
            emit(initialState);

            return;
          }

          final addressRiskResult = await fetchRiskInfoForAddress.run(initialState.searchAddress);
          addressRiskResult.fold((final failure) => emit(const MaifLoadFailure()), (final risks) {
            emit(initialState.copyWith(risks: risks));
          });
        });
      });
    });
    on<MaifAddressChanged>((final event, final emit) async {
      final currentState = state;
      if (currentState is! MaifLoadSuccess) {
        return;
      }
      emit(currentState.copyWith(isLoading: true));
      final address = event.value;
      final cityRiskResult = await repository.fetchCityRisk(address.cityCode);
      final addressRiskResult = await fetchRiskInfoForAddress.run(address);
      cityRiskResult.fold((final failure) => emit(const MaifLoadFailure()), (final cityRisk) {
        addressRiskResult.fold((final failure) => emit(const MaifLoadFailure()), (final risks) {
          emit(
            currentState.copyWith(
              searchAddress: address,
              risks: risks,
              numberOfCatNat: cityRisk.numberOfCatNat,
              droughtPercentage: cityRisk.droughtPercentage,
              floodPercentage: cityRisk.floodPercentage,
              isLoading: false,
            ),
          );
        });
      });
    });
    on<MaifNewAddressChosen>((final event, final emit) async {
      final currentState = state;
      if (currentState is! MaifLoadSuccess) {
        return;
      }
      final address = event.value;
      await userAddressRepository.updateAddress(address);
      emit(currentState.copyWith(userAddress: address));
    });
  }
}
