import 'package:app/features/authentification/core/domain/information_de_code.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_repository.dart';
import 'package:app/features/authentification/saisie_code/presentation/bloc/saisie_code_event.dart';
import 'package:app/features/authentification/saisie_code/presentation/bloc/saisie_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class SaisieCodeBloc extends Bloc<SaisieCodeEvent, SaisieCodeState> {
  SaisieCodeBloc({required final AuthentificationRepository authentificationRepository, required final String email})
    : super(SaisieCodeState(email: email, renvoyerCodeDemande: false, erreur: const None())) {
    on<SaisieCodeCodeSaisie>((final event, final emit) async {
      final code = event.code;

      if (code == null || code.isEmpty || code.length != 6) {
        return;
      }

      final result = await authentificationRepository.validationRequested(InformationDeCode(email: state.email, code: code));

      result.fold((final exception) => emit(state.copyWith(erreur: Some(exception.message))), (final _) {});
    });
  }
}
