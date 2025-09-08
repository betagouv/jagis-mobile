// ignore_for_file: avoid-long-parameter-list

import 'package:app/core/infrastructure/endpoints.dart';

import 'scenario_context.dart';

/// Iel a ces informations de profile.
void ielACesInformationsDeProfil({
  final String email = '',
  final String prenom = '',
  final String nom = '',
  final String codePostal = '',
  final String codeInsee = '',
  final double nombreDePartsFiscales = 0,
  final int? revenuFiscal,
}) {
  ScenarioContext().dioMock!.getM(
    Endpoints.profile,
    responseData: {
      'email': email,
      'is_nom_prenom_modifiable': true,
      'prenom': prenom,
      'nom': nom,
      'logement': {'code_postal': codePostal, 'code_commune': codeInsee},
      'revenu_fiscal': revenuFiscal,
      'nombre_de_parts_fiscales': nombreDePartsFiscales,
      'annee_naissance': null,
    },
  );
}
