import 'dart:async';

import 'package:app/features/communes/domain/ports/communes_port.dart';
import 'package:app/features/profil/domain/ports/profil_port.dart';
import 'package:app/features/profil/logement/domain/entities/logement.dart';
import 'package:app/features/profil/logement/presentation/blocs/mon_logement_event.dart';
import 'package:app/features/profil/logement/presentation/blocs/mon_logement_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonLogementBloc extends Bloc<MonLogementEvent, MonLogementState> {
  MonLogementBloc({
    required final ProfilPort profilPort,
    required final CommunesPort communesPort,
  })  : _profilPort = profilPort,
        _communesPort = communesPort,
        super(const MonLogementState.empty()) {
    on<MonLogementRecuperationDemandee>(_onRecuperationDemandee);
    on<MonLogementCodePostalChange>(_onCodePostalChange);
    on<MonLogementCommuneChange>(_onCommuneChange);
    on<MonLogementNombreAdultesChange>(_onNombreAdultesChange);
    on<MonLogementNombreEnfantsChange>(_onNombreEnfantsChange);
    on<MonLogementTypeDeLogementChange>(_onNombreTypeDeLogementChange);
    on<MonLogementEstProprietaireChange>(_onEstProprietaireChange);
    on<MonLogementSuperficieChange>(_onSuperficieChange);
    on<MonLogementChauffageChange>(_onChauffageChange);
    on<MonLogementPlusDe15AnsChange>(_onPlusDe15AnsChange);
    on<MonLogementDpeChange>(_onDpeChange);
    on<MonLogementMiseAJourDemandee>(_onMiseAJourDemandee);
  }

  final ProfilPort _profilPort;
  final CommunesPort _communesPort;

  Future<void> _onRecuperationDemandee(
    final MonLogementRecuperationDemandee event,
    final Emitter<MonLogementState> emit,
  ) async {
    emit(state.copyWith(statut: MonLogementStatut.chargement));
    final logement = await _profilPort.recupererLogement();
    final communes = logement.codePostal == null
        ? <String>[]
        : await _communesPort.recupererLesCommunes(logement.codePostal!);

    emit(
      state.copyWith(
        codePostal: logement.codePostal,
        communes: communes,
        commune: logement.commune,
        nombreAdultes: logement.nombreAdultes,
        nombreEnfants: logement.nombreEnfants,
        typeDeLogement: logement.typeDeLogement,
        estProprietaire: logement.estProprietaire,
        superficie: logement.superficie,
        chauffage: logement.chauffage,
        plusDe15Ans: logement.plusDe15Ans,
        dpe: logement.dpe,
        statut: MonLogementStatut.succes,
      ),
    );
  }

  Future<void> _onCodePostalChange(
    final MonLogementCodePostalChange event,
    final Emitter<MonLogementState> emit,
  ) async {
    final communes = await _communesPort.recupererLesCommunes(event.valeur);
    emit(
      state.copyWith(
        codePostal: event.valeur,
        communes: communes,
        commune: '',
      ),
    );
  }

  void _onCommuneChange(
    final MonLogementCommuneChange event,
    final Emitter<MonLogementState> emit,
  ) =>
      emit(state.copyWith(commune: event.valeur));

  void _onNombreAdultesChange(
    final MonLogementNombreAdultesChange event,
    final Emitter<MonLogementState> emit,
  ) =>
      emit(state.copyWith(nombreAdultes: event.valeur));

  void _onNombreEnfantsChange(
    final MonLogementNombreEnfantsChange event,
    final Emitter<MonLogementState> emit,
  ) =>
      emit(state.copyWith(nombreEnfants: event.valeur));

  void _onNombreTypeDeLogementChange(
    final MonLogementTypeDeLogementChange event,
    final Emitter<MonLogementState> emit,
  ) =>
      emit(state.copyWith(typeDeLogement: event.valeur));

  void _onEstProprietaireChange(
    final MonLogementEstProprietaireChange event,
    final Emitter<MonLogementState> emit,
  ) =>
      emit(state.copyWith(estProprietaire: event.valeur));

  void _onSuperficieChange(
    final MonLogementSuperficieChange event,
    final Emitter<MonLogementState> emit,
  ) =>
      emit(state.copyWith(superficie: event.valeur));

  void _onChauffageChange(
    final MonLogementChauffageChange event,
    final Emitter<MonLogementState> emit,
  ) =>
      emit(state.copyWith(chauffage: event.valeur));

  void _onPlusDe15AnsChange(
    final MonLogementPlusDe15AnsChange event,
    final Emitter<MonLogementState> emit,
  ) {
    emit(state.copyWith(plusDe15Ans: event.valeur));
  }

  void _onDpeChange(
    final MonLogementDpeChange event,
    final Emitter<MonLogementState> emit,
  ) {
    emit(state.copyWith(dpe: event.valeur));
  }

  Future<void> _onMiseAJourDemandee(
    final MonLogementMiseAJourDemandee event,
    final Emitter<MonLogementState> emit,
  ) async {
    await _profilPort.mettreAJourLogement(
      logement: Logement(
        codePostal: state.codePostal,
        commune: state.commune,
        nombreAdultes: state.nombreAdultes,
        nombreEnfants: state.nombreEnfants,
        typeDeLogement: state.typeDeLogement,
        estProprietaire: state.estProprietaire,
        superficie: state.superficie,
        chauffage: state.chauffage,
        plusDe15Ans: state.plusDe15Ans,
        dpe: state.dpe,
      ),
    );
  }
}
