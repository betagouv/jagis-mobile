// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_api_will_return.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_tap_on.dart';
import './step/the_api_receive.dart';
import './step/i_scroll_down_to.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''KYC edit''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
      await theApiWillReturn(
          tester,
          const bdd.DataTable([
            ['method', 'path', 'statusCode', 'responseData'],
            [
              'GET',
              '/utilisateurs/{userId}/questionsKYC_v2',
              200,
              [
                {
                  "code": "MOSAIC_CHAUFFAGE",
                  "question": "Quels modes de chauffage existent chez vous ?",
                  "reponse_multiple": [
                    {
                      "code": "KYC_chauffage_bois",
                      "label": "Bois",
                      "emoji": "🪵",
                      "image_url":
                          "https://res.cloudinary.com/dq023imd8/image/upload/v1726497242/Screenshot_2024_09_16_at_16_22_55_4fcb2d1a5b.png",
                      "selected": true
                    },
                    {
                      "code": "KYC_chauffage_fioul",
                      "label": "Fioul",
                      "emoji": "🛢️",
                      "image_url":
                          "https://res.cloudinary.com/dq023imd8/image/upload/v1726497260/Screenshot_2024_09_16_at_16_23_05_4103677680.png",
                      "selected": false
                    },
                    {
                      "code": "KYC_chauffage_gaz",
                      "label": "Gaz",
                      "emoji": "🏭",
                      "image_url":
                          "https://res.cloudinary.com/dq023imd8/image/upload/v1726497275/Screenshot_2024_09_16_at_16_23_19_1084c4bd18.png",
                      "selected": false
                    },
                    {
                      "code": "KYC_chauffage_elec",
                      "label": "Électricité",
                      "emoji": "⚡️",
                      "image_url":
                          "https://res.cloudinary.com/dq023imd8/image/upload/v1727275914/Screenshot_2024_09_25_at_16_51_08_876426bef9.png",
                      "selected": false
                    }
                  ],
                  "is_answered": true,
                  "categorie": "mission",
                  "points": 5,
                  "type": "mosaic_boolean",
                  "is_NGC": false,
                  "thematique": "logement"
                }
              ]
            ],
            [
              'GET',
              '/utilisateurs/{userId}/questionsKYC_v2/MOSAIC_CHAUFFAGE',
              200,
              {
                "code": "MOSAIC_CHAUFFAGE",
                "question": "Quels modes de chauffage existent chez vous ?",
                "reponse_multiple": [
                  {
                    "code": "KYC_chauffage_bois",
                    "label": "Bois",
                    "emoji": "🪵",
                    "image_url":
                        "https://res.cloudinary.com/dq023imd8/image/upload/v1726497242/Screenshot_2024_09_16_at_16_22_55_4fcb2d1a5b.png",
                    "selected": true
                  },
                  {
                    "code": "KYC_chauffage_fioul",
                    "label": "Fioul",
                    "emoji": "🛢️",
                    "image_url":
                        "https://res.cloudinary.com/dq023imd8/image/upload/v1726497260/Screenshot_2024_09_16_at_16_23_05_4103677680.png",
                    "selected": false
                  },
                  {
                    "code": "KYC_chauffage_gaz",
                    "label": "Gaz",
                    "emoji": "🏭",
                    "image_url":
                        "https://res.cloudinary.com/dq023imd8/image/upload/v1726497275/Screenshot_2024_09_16_at_16_23_19_1084c4bd18.png",
                    "selected": false
                  },
                  {
                    "code": "KYC_chauffage_elec",
                    "label": "Électricité",
                    "emoji": "⚡️",
                    "image_url":
                        "https://res.cloudinary.com/dq023imd8/image/upload/v1727275914/Screenshot_2024_09_25_at_16_51_08_876426bef9.png",
                    "selected": false
                  }
                ],
                "is_answered": true,
                "categorie": "mission",
                "points": 5,
                "type": "mosaic_boolean",
                "is_NGC": false,
                "thematique": "logement"
              }
            ],
            [
              "PUT",
              '/utilisateurs/{userId}/questionsKYC_v2/MOSAIC_CHAUFFAGE',
              200,
              {}
            ]
          ]));
      await theApplicationIsLaunched(tester);
      await iTapOnTheMenuButton(tester);
      await iTapOn(tester, 'Mon profil');
      await iTapOn(tester, 'Mes réponses');
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Question mosaique Répondre Fioul''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Question mosaique Répondre Fioul''');
        await bddSetUp(tester);
        await iTapOn(tester, 'Quels modes de chauffage existent chez vous ?');
        await iTapOn(tester, 'Fioul');
        await iTapOn(tester, 'Mettre à jour');
        await theApiReceive(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                "PUT",
                '/utilisateurs/{userId}/questionsKYC_v2/MOSAIC_CHAUFFAGE',
                200,
                [
                  {"code": "KYC_chauffage_bois", "selected": true},
                  {"code": "KYC_chauffage_fioul", "selected": true},
                  {"code": "KYC_chauffage_gaz", "selected": false},
                  {"code": "KYC_chauffage_elec", "selected": false}
                ]
              ]
            ]));
      } catch (_) {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Question mosaique Répondre Fioul''',
          success,
        );
      }
    });
    testWidgets('''Question mosaique Répondre aucune de ces propostions''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Question mosaique Répondre aucune de ces propostions''');
        await bddSetUp(tester);
        await iTapOn(tester, 'Quels modes de chauffage existent chez vous ?');
        await iScrollDownTo(tester, 'Aucune de ces propositions');
        await iTapOn(tester, 'Aucune de ces propositions');
        await theApiReceive(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                "PUT",
                '/utilisateurs/{userId}/questionsKYC_v2/MOSAIC_CHAUFFAGE',
                200,
                [
                  {"code": "KYC_chauffage_bois", "selected": false},
                  {"code": "KYC_chauffage_fioul", "selected": false},
                  {"code": "KYC_chauffage_gaz", "selected": false},
                  {"code": "KYC_chauffage_elec", "selected": false}
                ]
              ]
            ]));
      } catch (_) {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Question mosaique Répondre aucune de ces propostions''',
          success,
        );
      }
    });
  });
}
