import 'package:app/features/profil/core/infrastructure/profil_repository.dart';
import 'package:app/features/profil/informations/presentation/bloc/mes_informations_event.dart';
import 'package:app/features/profil/informations/presentation/bloc/mes_informations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class MesInformationsBloc extends Bloc<MesInformationsEvent, MesInformationsState> {
  MesInformationsBloc({required final ProfilRepository profilRepository}) : super(const MesInformationsState.empty()) {
    on<MesInformationsRecuperationDemandee>((final event, final emit) async {
      emit(state.copyWith(statut: MesInformationsStatut.chargement));
      final result = await profilRepository.recupererProfil();
      if (result.isRight()) {
        final profil = result.getRight().getOrElse(() => throw Exception());
        final dateTime =
            profil.anneeDeNaissance != null && profil.moisDeNaissance != null && profil.jourDeNaissance != null
                ? DateTime(profil.anneeDeNaissance!, profil.moisDeNaissance!, profil.jourDeNaissance!)
                : null;
        emit(
          MesInformationsState(
            isUserFranceConnect: profil.isUserFranceConnect,
            email: profil.email,
            pseudonym: profil.pseudonym,
            prenom: profil.prenom,
            nom: profil.nom,
            birthdate: dateTime,
            nombreDePartsFiscales: profil.nombreDePartsFiscales,
            revenuFiscal: profil.revenuFiscal,
            statut: MesInformationsStatut.succes,
          ),
        );
      }
    });
    on<MesInformationsPseudonymChange>((final event, final emit) => emit(state.copyWith(pseudonym: event.valeur)));
    on<MesInformationsPrenomChange>((final event, final emit) => emit(state.copyWith(prenom: event.valeur)));
    on<MesInformationsNomChange>((final event, final emit) => emit(state.copyWith(nom: event.valeur)));
    on<MesInformationsBirthdateChanged>((final event, final emit) => emit(state.copyWith(birthdate: event.valeur)));
    on<MesInformationsNombreDePartsFiscalesChange>(
      (final event, final emit) => emit(state.copyWith(nombreDePartsFiscales: event.valeur)),
    );
    on<MesInformationsRevenuFiscalChange>((final event, final emit) => emit(state.copyWith(revenuFiscal: event.valeur)));
    on<MesInformationsMiseAJourDemandee>(
      (final event, final emit) async => profilRepository.updateInformation(
        pseudonym: state.pseudonym,
        prenom: state.prenom,
        nom: state.nom,
        anneeDeNaissance: state.birthdate?.year,
        moisDeNaissance: state.birthdate?.month,
        jourDeNaissance: state.birthdate?.day,
        nombreDePartsFiscales: state.nombreDePartsFiscales,
        revenuFiscal: state.revenuFiscal,
      ),
    );
  }
}
