// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_api_will_return.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_text.dart';
import './step/i_tap_on.dart';
import './step/i_see.dart';
import './step/the_api_receive.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Près de chez nous''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
      await theApiWillReturn(
          tester,
          const bdd.DataTable([
            ['method', 'path', 'statusCode', 'responseData'],
            [
              'GET',
              '/utilisateurs/%7BuserId%7D/aides_v2?thematique=alimentation',
              200,
              {"couverture_aides_ok": false, "liste_aides": []}
            ],
            [
              'GET',
              '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/ENCHAINEMENT_KYC_personnalisation_alimentation/first',
              200,
              {
                "nombre_total_questions": 4,
                "nombre_total_questions_effectives": 4,
                "position_courante": 3,
                "question_courante": {
                  "code": "MOSAIC_REDUCTION_DECHETS",
                  "question":
                      "Quels éco-gestes mettez-vous en place pour réduire vos déchets ?",
                  "reponse_multiple": [
                    {
                      "code": "KYC_alimentation_compostage",
                      "label": "Compostage biodéchets",
                      "emoji": null,
                      "image_url":
                          "https://res.cloudinary.com/dq023imd8/image/upload/v1728749522/482602_8af4f622d9.png",
                      "selected": false
                    },
                    {
                      "code": "KYC_alimentation_reduc_gaspi_alim",
                      "label": "Réduire gaspillage alimentaire",
                      "emoji": null,
                      "image_url":
                          "https://res.cloudinary.com/dq023imd8/image/upload/v1728749522/482602_8af4f622d9.png",
                      "selected": false
                    },
                    {
                      "code": "KYC_alimentation_stoppub",
                      "label": "Stop pub",
                      "emoji": null,
                      "image_url":
                          "https://res.cloudinary.com/dq023imd8/image/upload/v1728749522/482602_8af4f622d9.png",
                      "selected": true
                    },
                    {
                      "code": "KYC_alimentation_achat_vrac",
                      "label": "Achat en vrac",
                      "emoji": null,
                      "image_url":
                          "https://res.cloudinary.com/dq023imd8/image/upload/v1728749522/482602_8af4f622d9.png",
                      "selected": false
                    }
                  ],
                  "is_answered": true,
                  "categorie": "mission",
                  "points": 5,
                  "type": "mosaic_boolean",
                  "is_NGC": false,
                  "thematique": "dechet"
                },
                "is_first": false,
                "is_last": false,
                "is_out_of_range": false
              }
            ],
            [
              'GET',
              '/utilisateurs/{userId}/recherche_services/proximite/categories',
              200,
              [
                {
                  "code": "nourriture",
                  "label": "Tous les commerces",
                  "is_default": true
                },
                {
                  "code": "circuit_court",
                  "label": "Les producteurs locaux",
                  "is_default": false
                },
                {
                  "code": "epicerie_superette",
                  "label": "Les épiceries et supérettes",
                  "is_default": false
                },
                {
                  "code": "marche_local",
                  "label": "Les marchés locaux",
                  "is_default": false
                },
                {
                  "code": "zero_dechet",
                  "label": "Les boutiques zéro déchet",
                  "is_default": false
                }
              ]
            ],
            [
              'POST',
              '/utilisateurs/{userId}/recherche_services/proximite/search2',
              200,
              {
                "encore_plus_resultats_dispo": false,
                "resultats": [
                  {
                    "id": "BG1",
                    "titre": "EARL les maraîchers du Val d'Amour",
                    "adresse_code_postal": "39120",
                    "adresse_nom_ville": "Rahon",
                    "adresse_rue": "6, ruelle des Merles",
                    "est_favoris": false,
                    "nombre_favoris": 0,
                    "distance_metres": 605,
                    "image_url": null,
                    "description":
                        "Maraîcher bio en demi gros. Légumes de saison.",
                    "phone": "09 61 48 96 07",
                    "categories": [
                      "Alimentation et Agriculture",
                      "Légumes",
                      "Circuits courts",
                      "Producteur / Artisan"
                    ],
                    "open_hours": [],
                    "latitude": 46.99214,
                    "longitude": 5.4661,
                    "ingredients": [],
                    "etapes_recette": [],
                    "categories_labels": [
                      "Alimentation et Agriculture",
                      "Légumes",
                      "Circuits courts",
                      "Producteur / Artisan"
                    ]
                  }
                ]
              }
            ]
          ]));
      await theApplicationIsLaunched(tester);
      await iTapOnText(tester, 1, '🍛 Me nourrir');
      await iTapOn(tester, 'Les commerces locaux');
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Voir les suggestions''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Voir les suggestions''');
        await bddSetUp(tester);
        await iSee(tester, "EARL les maraîchers du Val d'Amour");
        await theApiReceive(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'POST',
                "/utilisateurs/{userId}/recherche_services/proximite/search2",
                200,
                {
                  "categorie": "nourriture",
                  "nombre_max_resultats": 9,
                  "rayon_metres": 5000
                }
              ]
            ]));
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir les suggestions''',
          success,
        );
      }
    });
    testWidgets('''Choisir une catégorie''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Choisir une catégorie''');
        await bddSetUp(tester);
        await iTapOn(tester, 'Tous les commerces');
        await iTapOn(tester, 'Les producteurs locaux');
        await iSee(tester, "EARL les maraîchers du Val d'Amour");
        await theApiReceive(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'POST',
                "/utilisateurs/{userId}/recherche_services/proximite/search2",
                200,
                {
                  "categorie": "circuit_court",
                  "nombre_max_resultats": 9,
                  "rayon_metres": 5000
                }
              ]
            ]));
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Choisir une catégorie''',
          success,
        );
      }
    });
  });
}
