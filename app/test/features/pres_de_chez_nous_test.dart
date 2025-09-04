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
            ]
          ]));
      await theApplicationIsLaunched(tester);
      await iTapOnText(tester, 1, '🍛 Me nourrir');
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Voir le détail avec un téléphone''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Voir le détail avec un téléphone''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
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
                  "encore_plus_resultats_dispo": true,
                  "resultats": [
                    {
                      "id": "IAH",
                      "titre": "Accorderie de Chambery",
                      "site_web":
                          "http://www.accorderie.fr/chambery/laccorderie-de-chambery/",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "distance_metres": 1506,
                      "image_url":
                          "https://presdecheznous.gogocarto.fr/uploads/presdecheznous/images/elements/CapOuPasCap/2018/11/logo.jpg",
                      "description":
                          "Le principe est simple, chacun fait pour les autres ce qu’il sait faire selon ses disponibilités. Quand un accordeur rend un service, il reçoit du bénéficiaire un chèque-temps qu’il pourra utiliser plus tard pour demander à d’autres un coup de main.\\r\nLes services échangés sont comptabilisés grâce à des chèques-temps sur la base du temps réel nécessaire pour rendre le service demandé. La comptabilité se fait à partir d’un compte-temps où sont relevés les heures données et reçues.\\r\nLors de son inscription, tout nouveau accordeur reçoit sur son compte temps un crédit de 15h00 pour lui permettre d’échanger des services immédiatement.\\r\nA Chambéry, les 1411 Accordeur(e)s ont déjà échangé plus de 12600 heures de services.",
                      "phone": "04 79 96 13 49",
                      "categories": ["S.E.L / R.E.R.S", "Systèmes d'échanges"],
                      "openhours_more_infos":
                          "mardi 16-20H, mercredi 14h - 17h, jeudi 10h-16h",
                      "open_hours": [],
                      "latitude": 45.59573,
                      "longitude": 5.91668,
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": [
                        "S.E.L / R.E.R.S",
                        "Systèmes d'échanges"
                      ],
                      "adresse_complete": ""
                    }
                  ]
                }
              ],
              [
                'GET',
                '/utilisateurs/{userId}/recherche_services/proximite/last_results/IAH',
                200,
                {
                  "id": "IAH",
                  "titre": "Accorderie de Chambery",
                  "site_web":
                      "http://www.accorderie.fr/chambery/laccorderie-de-chambery/",
                  "est_favoris": false,
                  "nombre_favoris": 0,
                  "distance_metres": 1506,
                  "image_url":
                      "https://presdecheznous.gogocarto.fr/uploads/presdecheznous/images/elements/CapOuPasCap/2018/11/logo.jpg",
                  "description":
                      "Le principe est simple, chacun fait pour les autres ce qu’il sait faire selon ses disponibilités. Quand un accordeur rend un service, il reçoit du bénéficiaire un chèque-temps qu’il pourra utiliser plus tard pour demander à d’autres un coup de main.\\r\nLes services échangés sont comptabilisés grâce à des chèques-temps sur la base du temps réel nécessaire pour rendre le service demandé. La comptabilité se fait à partir d’un compte-temps où sont relevés les heures données et reçues.\\r\nLors de son inscription, tout nouveau accordeur reçoit sur son compte temps un crédit de 15h00 pour lui permettre d’échanger des services immédiatement.\\r\nA Chambéry, les 1411 Accordeur(e)s ont déjà échangé plus de 12600 heures de services.",
                  "phone": "04 79 96 13 49",
                  "categories": ["S.E.L / R.E.R.S", "Systèmes d'échanges"],
                  "openhours_more_infos":
                      "mardi 16-20H, mercredi 14h - 17h, jeudi 10h-16h",
                  "open_hours": [],
                  "latitude": 45.59573,
                  "longitude": 5.91668,
                  "ingredients": [],
                  "etapes_recette": [],
                  "categories_labels": [
                    "S.E.L / R.E.R.S",
                    "Systèmes d'échanges"
                  ],
                  "adresse_complete": ""
                }
              ]
            ]));
        await iTapOn(tester, 'Les commerces locaux');
        await iTapOn(tester, 'Accorderie de Chambery');
        await iSee(tester, 'Accorderie de Chambery');
      } catch (_) {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir le détail avec un téléphone''',
          success,
        );
      }
    });
    testWidgets('''Voir le détail avec une liste de téléphone''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Voir le détail avec une liste de téléphone''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
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
                  "encore_plus_resultats_dispo": true,
                  "resultats": [
                    {
                      "id": "IAB",
                      "titre": "Accorderie de Chambery",
                      "site_web":
                          "http://www.accorderie.fr/chambery/laccorderie-de-chambery/",
                      "est_favoris": false,
                      "nombre_favoris": 0,
                      "distance_metres": 1506,
                      "image_url":
                          "https://presdecheznous.gogocarto.fr/uploads/presdecheznous/images/elements/CapOuPasCap/2018/11/logo.jpg",
                      "description":
                          "Le principe est simple, chacun fait pour les autres ce qu’il sait faire selon ses disponibilités. Quand un accordeur rend un service, il reçoit du bénéficiaire un chèque-temps qu’il pourra utiliser plus tard pour demander à d’autres un coup de main.\\r\nLes services échangés sont comptabilisés grâce à des chèques-temps sur la base du temps réel nécessaire pour rendre le service demandé. La comptabilité se fait à partir d’un compte-temps où sont relevés les heures données et reçues.\\r\nLors de son inscription, tout nouveau accordeur reçoit sur son compte temps un crédit de 15h00 pour lui permettre d’échanger des services immédiatement.\\r\nA Chambéry, les 1411 Accordeur(e)s ont déjà échangé plus de 12600 heures de services.",
                      "phone": ["04 79 96 13 49"],
                      "categories": ["S.E.L / R.E.R.S", "Systèmes d'échanges"],
                      "openhours_more_infos":
                          "mardi 16-20H, mercredi 14h - 17h, jeudi 10h-16h",
                      "open_hours": [],
                      "latitude": 45.59573,
                      "longitude": 5.91668,
                      "ingredients": [],
                      "etapes_recette": [],
                      "categories_labels": [
                        "S.E.L / R.E.R.S",
                        "Systèmes d'échanges"
                      ],
                      "adresse_complete": ""
                    }
                  ]
                }
              ],
              [
                'GET',
                '/utilisateurs/{userId}/recherche_services/proximite/last_results/IAB',
                200,
                {
                  "id": "IAB",
                  "titre": "Accorderie de Chambery",
                  "site_web":
                      "http://www.accorderie.fr/chambery/laccorderie-de-chambery/",
                  "est_favoris": false,
                  "nombre_favoris": 0,
                  "distance_metres": 1506,
                  "image_url":
                      "https://presdecheznous.gogocarto.fr/uploads/presdecheznous/images/elements/CapOuPasCap/2018/11/logo.jpg",
                  "description":
                      "Le principe est simple, chacun fait pour les autres ce qu’il sait faire selon ses disponibilités. Quand un accordeur rend un service, il reçoit du bénéficiaire un chèque-temps qu’il pourra utiliser plus tard pour demander à d’autres un coup de main.\\r\nLes services échangés sont comptabilisés grâce à des chèques-temps sur la base du temps réel nécessaire pour rendre le service demandé. La comptabilité se fait à partir d’un compte-temps où sont relevés les heures données et reçues.\\r\nLors de son inscription, tout nouveau accordeur reçoit sur son compte temps un crédit de 15h00 pour lui permettre d’échanger des services immédiatement.\\r\nA Chambéry, les 1411 Accordeur(e)s ont déjà échangé plus de 12600 heures de services.",
                  "phone": ["04 79 96 13 49", "04 79 96 13 49"],
                  "categories": ["S.E.L / R.E.R.S", "Systèmes d'échanges"],
                  "openhours_more_infos":
                      "mardi 16-20H, mercredi 14h - 17h, jeudi 10h-16h",
                  "open_hours": [],
                  "latitude": 45.59573,
                  "longitude": 5.91668,
                  "ingredients": [],
                  "etapes_recette": [],
                  "categories_labels": [
                    "S.E.L / R.E.R.S",
                    "Systèmes d'échanges"
                  ],
                  "adresse_complete": ""
                }
              ]
            ]));
        await iTapOn(tester, 'Les commerces locaux');
        await iTapOn(tester, 'Accorderie de Chambery');
        await iSee(tester, 'Accorderie de Chambery');
      } catch (_) {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir le détail avec une liste de téléphone''',
          success,
        );
      }
    });
  });
}
