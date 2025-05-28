import 'package:app/features/authentification/core/infrastructure/authentification_repository.dart';
import 'package:app/features/authentification/se_connecter/presentation/bloc/se_connecter_event.dart';
import 'package:app/features/authentification/se_connecter/presentation/bloc/se_connecter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class SeConnecterBloc extends Bloc<SeConnecterEvent, SeConnecterState> {
  SeConnecterBloc(final AuthentificationRepository authentificationRepository) : super(const SeConnecterState.empty()) {
    on<SeConnecterAdresseMailAChange>((final event, final emit) => emit(state.copyWith(email: event.value)));
    on<SeConnecterConnexionDemandee>((final event, final emit) async {
      emit(state.copyWith(isConnected: false));
      final result = await authentificationRepository.loginRequested(state.email);

      result.fold(
        (final exception) => emit(state.copyWith(errorMessage: Some(exception.message))),
        (final _) => emit(state.copyWith(isConnected: true)),
      );
    });
  }
}
