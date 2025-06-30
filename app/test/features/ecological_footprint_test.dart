// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_api_will_return.dart';
import './step/the_application_is_launched.dart';
import './step/i_see.dart';
import './step/i_tap_on.dart';
import './step/i_go_back.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Ecological footprint''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets(
        '''Voir l'incitation à calculer son empreinte écologique lorsqu'il n'est pas terminé''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Voir l'incitation à calculer son empreinte écologique lorsqu'il n'est pas terminé''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/home_board',
                200,
                {
                  "nom_commune": "Lyon",
                  "total_national_actions_faites": 36,
                  "total_utilisateur_actions_faites": 3,
                  "pourcentage_bilan_done": 39,
                  "nombre_aides": 12,
                  "nombre_recettes": 1150,
                  "bilan_carbone_total_kg": 7569.006294661004,
                  "pourcentage_alimentation_reco_done": 100,
                  "pourcentage_consommation_reco_done": 100,
                  "pourcentage_logement_reco_done": 100,
                  "pourcentage_transport_reco_done": 33,
                  "pourcentage_global_reco_done": 86
                }
              ]
            ]));
        await theApplicationIsLaunched(tester);
        await iSee(tester, 'Calculer mon\nempreinte écologique');
        await iSee(tester, '39%');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir l'incitation à calculer son empreinte écologique lorsqu'il n'est pas terminé''',
          success,
        );
      }
    });
    testWidgets('''Voir son empreinte écologique lorsqu'il est terminé''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Voir son empreinte écologique lorsqu'il est terminé''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/home_board',
                200,
                {
                  "nom_commune": "Lyon",
                  "total_national_actions_faites": 36,
                  "total_utilisateur_actions_faites": 3,
                  "pourcentage_bilan_done": 100,
                  "nombre_aides": 12,
                  "nombre_recettes": 1150,
                  "bilan_carbone_total_kg": 7569.006294661004,
                  "pourcentage_alimentation_reco_done": 100,
                  "pourcentage_consommation_reco_done": 100,
                  "pourcentage_logement_reco_done": 100,
                  "pourcentage_transport_reco_done": 33,
                  "pourcentage_global_reco_done": 86
                }
              ]
            ]));
        await theApplicationIsLaunched(tester);
        await iSee(tester, 'Mon empreinte\nécologique');
        await iSee(tester, '8t\nde CO2e/an');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir son empreinte écologique lorsqu'il est terminé''',
          success,
        );
      }
    });
    testWidgets(
        '''Répondre à une question liées à mon empreinte écologique lorsque je reviens en arrière alors le pourcentage doit être mis à jour''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Répondre à une question liées à mon empreinte écologique lorsque je reviens en arrière alors le pourcentage doit être mis à jour''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/home_board',
                200,
                {
                  "nom_commune": "Lyon",
                  "total_national_actions_faites": 36,
                  "total_utilisateur_actions_faites": 3,
                  "pourcentage_bilan_done": 39,
                  "nombre_aides": 12,
                  "nombre_recettes": 1150,
                  "bilan_carbone_total_kg": 7569.006294661004,
                  "pourcentage_alimentation_reco_done": 100,
                  "pourcentage_consommation_reco_done": 100,
                  "pourcentage_logement_reco_done": 100,
                  "pourcentage_transport_reco_done": 33,
                  "pourcentage_global_reco_done": 86
                }
              ],
              [
                'GET',
                '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/ENCHAINEMENT_KYC_bilan_transport',
                200,
                [
                  {
                    "code": "KYC_transport_avion_3_annees",
                    "question":
                        "Avez-vous pris l'avion au moins une fois ces 3 dernières années ?",
                    "reponse_multiple": [
                      {"code": "oui", "label": "Oui", "selected": false},
                      {"code": "non", "label": "Non", "selected": false},
                      {
                        "code": "ne_sais_pas",
                        "label": "Je ne sais pas",
                        "selected": false
                      }
                    ],
                    "is_answered": false,
                    "categorie": "mission",
                    "points": 5,
                    "type": "choix_unique",
                    "is_NGC": true,
                    "thematique": "transport"
                  }
                ]
              ],
              [
                'GET',
                '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/ENCHAINEMENT_KYC_bilan_transport/first',
                200,
                {
                  "nombre_total_questions": 13,
                  "nombre_total_questions_effectives": 11,
                  "position_courante": 1,
                  "question_courante": {
                    "code": "KYC_transport_avion_3_annees",
                    "question":
                        "Avez-vous pris l'avion au moins une fois ces 3 dernières années ?",
                    "reponse_multiple": [
                      {"code": "oui", "label": "Oui", "selected": false},
                      {"code": "non", "label": "Non", "selected": false},
                      {
                        "code": "ne_sais_pas",
                        "label": "Je ne sais pas",
                        "selected": false
                      }
                    ],
                    "is_answered": false,
                    "categorie": "mission",
                    "points": 5,
                    "type": "choix_unique",
                    "is_NGC": true,
                    "thematique": "transport"
                  },
                  "is_first": true,
                  "is_last": false,
                  "is_out_of_range": false
                }
              ],
              [
                'GET',
                '/utilisateurs/{userId}/questionsKYC_v2/KYC_transport_avion_3_annees',
                200,
                {
                  "code": "KYC_transport_avion_3_annees",
                  "question":
                      "Avez-vous pris l'avion au moins une fois ces 3 dernières années ?",
                  "reponse_multiple": [
                    {"code": "oui", "label": "Oui", "selected": false},
                    {"code": "non", "label": "Non", "selected": false},
                    {
                      "code": "ne_sais_pas",
                      "label": "Je ne sais pas",
                      "selected": false
                    }
                  ],
                  "is_answered": false,
                  "categorie": "mission",
                  "points": 5,
                  "type": "choix_unique",
                  "is_NGC": true,
                  "thematique": "transport"
                }
              ]
            ]));
        await theApplicationIsLaunched(tester);
        await iSee(tester, '39%');
        await iTapOn(tester, 'Calculer mon\nempreinte écologique');
        await iTapOn(tester, 'Transport');
        await iTapOn(tester, 'Oui');
        await iGoBack(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/home_board',
                200,
                {
                  "nom_commune": "Lyon",
                  "total_national_actions_faites": 36,
                  "total_utilisateur_actions_faites": 3,
                  "pourcentage_bilan_done": 69,
                  "nombre_aides": 12,
                  "nombre_recettes": 1150,
                  "bilan_carbone_total_kg": 7569.006294661004,
                  "pourcentage_alimentation_reco_done": 100,
                  "pourcentage_consommation_reco_done": 100,
                  "pourcentage_logement_reco_done": 100,
                  "pourcentage_transport_reco_done": 33,
                  "pourcentage_global_reco_done": 86
                }
              ]
            ]));
        await iGoBack(tester);
        await iSee(tester, '69%');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Répondre à une question liées à mon empreinte écologique lorsque je reviens en arrière alors le pourcentage doit être mis à jour''',
          success,
        );
      }
    });
  });
}
