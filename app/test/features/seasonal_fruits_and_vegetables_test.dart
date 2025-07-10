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
import './step/i_scroll_down_to.dart';
import './step/i_tap_on.dart';
import './step/i_see.dart';
import './step/i_dont_see.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Seasonal fruits and vegetables service''', () {
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
      await iScrollDownTo(tester, 'Les fruits et légumes de septembre');
      await iTapOn(tester, 'Les fruits et légumes de septembre');
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''See seasonal fruits and vegetables''', (tester) async {
      var success = true;
      try {
        await beforeEach('''See seasonal fruits and vegetables''');
        await bddSetUp(tester);
        await iSee(tester, 'Les fruits et légumes pour le mois de');
        await iSee(tester, 'janvier');
        await iSee(tester, 'Poire');
        await iDontSee(tester, 'Fraise');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''See seasonal fruits and vegetables''',
          success,
        );
      }
    });
    testWidgets(
        '''Change the month to view different seasonal fruits and vegetables''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Change the month to view different seasonal fruits and vegetables''');
        await bddSetUp(tester);
        await iTapOn(tester, 'janvier');
        await iTapOn(tester, 'juin');
        await iSee(tester, 'Fraise');
        await iDontSee(tester, 'Poire');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Change the month to view different seasonal fruits and vegetables''',
          success,
        );
      }
    });
  });
}
