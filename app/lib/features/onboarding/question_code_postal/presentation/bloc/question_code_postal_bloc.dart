import 'package:app/features/communes/infrastructure/communes_repository.dart';
import 'package:app/features/communes/municipality.dart';
import 'package:app/features/onboarding/question_code_postal/presentation/bloc/question_code_postal_event.dart';
import 'package:app/features/onboarding/question_code_postal/presentation/bloc/question_code_postal_state.dart';
import 'package:app/features/profil/core/infrastructure/profil_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class QuestionCodePostalBloc extends Bloc<QuestionCodePostalEvent, QuestionCodePostalState> {
  QuestionCodePostalBloc({required final ProfilRepository profilRepository, required final CommunesRepository communesRepository})
    : super(const QuestionCodePostalState(pseudonym: '', codePostal: '', communes: [], codeInsee: '', aEteChange: false)) {
    on<QuestionCodePostalPseudonymDemande>((final event, final emit) async {
      final result = await profilRepository.recupererProfil();
      if (result.isRight()) {
        final profil = result.getRight().getOrElse(() => throw Exception());
        emit(state.copyWith(pseudonym: profil.pseudonym));
      }
    });
    on<QuestionCodePostalAChange>((final event, final emit) async {
      final communes = event.valeur.length == 5 ? await communesRepository.fetchMunicipalities(event.valeur) : <Municipality>[];
      emit(
        state.copyWith(codePostal: event.valeur, communes: communes, codeInsee: communes.length == 1 ? communes.first.code : ''),
      );
    });
    on<QuestionCommuneAChange>((final event, final emit) => emit(state.copyWith(codeInsee: event.valeur)));
    on<QuestionCodePostalMiseAJourDemandee>((final event, final emit) async {
      await profilRepository.mettreAJourCodePostalEtCommune(codePostal: state.codePostal, codeInsee: state.codeInsee);

      emit(state.copyWith(aEteChange: true));
    });
  }
}
