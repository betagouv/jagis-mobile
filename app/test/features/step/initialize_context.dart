import 'dart:convert';

import 'package:app/core/infrastructure/endpoints.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../environmental_performance/summary/environmental_performance_data.dart';
import '../../helpers/dio_mock.dart';
import '../../old/api/flutter_secure_storage_fake.dart';
import '../helper/feature_context.dart';

/// Usage: initialize context
Future<void> initializeContext(final WidgetTester tester) async {
  FeatureContext.reset();
  FeatureContext.instance.secureStorage = FlutterSecureStorageFake();
  FeatureContext.instance.dioMock = DioMock();
  setNotification();
  setFirstName();
  setProfile();
  setDeleteAccount();
  setForgotPassword();
  setCommunes();
  setLogement();
  setPreferences();
  setBilanEmpty();
  setMiniBilan();
  setMissionRecommanded();
  setMissionRecommandedByThematique();
  setAssistances();
  setPoints();
  setActions();
  setRecommandations();
  setServices();
}

void setNotification() {
  FeatureContext.instance.dioMock.deleteM(Endpoints.notificationToken);
  FeatureContext.instance.dioMock.putM(Endpoints.notificationToken);
}

void setFirstName() => FeatureContext.instance.dioMock.patchM(
      Endpoints.profile,
    );

void setProfile() => FeatureContext.instance.dioMock.getM(
      Endpoints.profile,
      responseData: jsonDecode('''
{
    "email": "joe@doe.fr",
    "nom": null,
    "prenom": null,
    "code_postal": null,
    "commune": null,
    "revenu_fiscal": null,
    "nombre_de_parts_fiscales": 1,
    "annee_naissance": null
}'''),
    );

void setLogement() => FeatureContext.instance.dioMock.patchM(
      Endpoints.logement,
    );

void setBilanEmpty() => FeatureContext.instance.dioMock
    .getM(Endpoints.bilan, responseData: environmentalPerformanceEmptyData);

void setMiniBilan() => FeatureContext.instance.dioMock.getM(
      Endpoints.questions('ENCHAINEMENT_KYC_mini_bilan_carbone'),
      responseData: miniBilan,
    );

void setMissionRecommanded() => FeatureContext.instance.dioMock
    .getM(Endpoints.missionsRecommandees, responseData: <dynamic>[]);

void setMissionRecommandedByThematique() =>
    FeatureContext.instance.dioMock.getM(
      Endpoints.missionsRecommandeesParThematique('alimentation'),
      responseData: <dynamic>[],
    );

void setAssistances() => FeatureContext.instance.dioMock.getM(
      Endpoints.assistances,
      responseData: {
        'couverture_aides_ok': false,
        'liste_aides': <dynamic>[],
      },
    );

void setPoints() => FeatureContext.instance.dioMock.getM(
      Endpoints.gamification,
      responseData: {'points': 0},
    );

void setPreferences() => FeatureContext.instance.dioMock
  ..getM(
    Endpoints.questionKyc('KYC_preference'),
    responseData: {
      'code': 'KYC_preference',
      'question':
          'Sur quels thèmes recherchez-vous en priorité des aides et conseils ?',
      'reponse_multiple': [
        {
          'code': 'alimentation',
          'label': 'La cuisine et l’alimentation',
          'selected': false,
        },
        {'code': 'transport', 'label': 'Mes déplacements', 'selected': false},
        {'code': 'logement', 'label': 'Mon logement', 'selected': false},
        {
          'code': 'consommation',
          'label': 'Ma consommation',
          'selected': false,
        },
        {
          'code': 'ne_sais_pas',
          'label': 'Je ne sais pas encore',
          'selected': false,
        },
      ],
      'is_answered': true,
      'categorie': 'recommandation',
      'points': 0,
      'type': 'choix_multiple',
      'is_NGC': false,
      'thematique': 'climat',
    },
  )
  ..putM(Endpoints.questionKyc('KYC_preference'));

void setDeleteAccount() =>
    FeatureContext.instance.dioMock.deleteM(Endpoints.utilisateur);

void setForgotPassword() => FeatureContext.instance.dioMock
  ..postM(Endpoints.oubliMotDePasse)
  ..postM(Endpoints.modifierMotDePasse);

void setCommunes() => FeatureContext.instance.dioMock.getM(
      Uri(path: Endpoints.communes, queryParameters: {'code_postal': '39100'})
          .toString(),
      responseData: jsonDecode('''
[
  "AUTHUME",
  "BAVERANS",
  "BREVANS",
  "CHAMPVANS",
  "CHOISEY",
  "CRISSEY",
  "DOLE",
  "FOUCHERANS",
  "GEVRY",
  "JOUHE",
  "MONNIERES",
  "PARCEY",
  "SAMPANS",
  "VILLETTE LES DOLE"
]'''),
    );

void setActions() => FeatureContext.instance.dioMock
  ..getM(
    '/utilisateurs/%7BuserId%7D/defis_v2?status=en_cours',
    responseData: <dynamic>[],
  )
  ..getM(
    '/utilisateurs/%7BuserId%7D/defis_v2?status=en_cours&thematique=alimentation',
    responseData: <dynamic>[],
  );

void setRecommandations() => FeatureContext.instance.dioMock
  ..getM(
    Endpoints.recommandationsParThematique('alimentation'),
    responseData: <dynamic>[],
  );

void setServices() => FeatureContext.instance.dioMock
  ..getM(
    Endpoints.servicesParThematique('alimentation'),
    responseData: jsonDecode('''
[
 {
      "id_service": "fruits_legumes",
      "titre": "Fruits et légumes de saison",
      "sous_titre": "janvier",
      "external_url": "https://impactco2.fr/outils/fruitsetlegumes",
      "icon_url": "https://agir-front-dev.osc-fr1.scalingo.io/cerise.webp",
      "thematique": "alimentation",
      "is_available_inhouse": true
  }
]'''),
  );
