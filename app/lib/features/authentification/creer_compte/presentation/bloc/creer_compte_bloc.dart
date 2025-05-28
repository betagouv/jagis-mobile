import 'package:app/features/authentification/core/infrastructure/authentification_repository.dart';
import 'package:app/features/authentification/creer_compte/presentation/bloc/creer_compte_event.dart';
import 'package:app/features/authentification/creer_compte/presentation/bloc/creer_compte_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class CreerCompteBloc extends Bloc<CreerCompteEvent, CreerCompteState> {
  CreerCompteBloc({required final AuthentificationRepository authentificationRepository})
    : super(const CreerCompteState.empty()) {
    on<CreerCompteAdresseMailAChangee>((final event, final emit) {
      emit(state.copyWith(email: event.valeur));
    });
    on<CreerCompteCreationDemandee>((final event, final emit) async {
      emit(state.copyWith(isAccountCreated: false));
      final result = await authentificationRepository.accountCreationRequested(state.email);
      result.fold(
        (final exception) => emit(state.copyWith(errorMessage: Some(exception.message))),
        (final _) => emit(state.copyWith(isAccountCreated: true)),
      );
    });
  }
}
