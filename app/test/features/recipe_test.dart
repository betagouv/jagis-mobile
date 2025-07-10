// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_have_actions_in_my_library.dart';
import './step/i_have_action_detail_in_my_library.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_tap_on.dart';
import './step/i_have_recipe_services_in_my_library.dart';
import './step/i_have_recipe_detail_in_my_library.dart';
import './step/i_scroll_down_to.dart';
import './step/i_see.dart';
import './step/the_api_will_return.dart';
import './step/i_tap_on_text.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Recipe''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''See recipe detail''', (tester) async {
      var success = true;
      try {
        await beforeEach('''See recipe detail''');
        await bddSetUp(tester);
        await iHaveActionsInMyLibrary(
            tester,
            const bdd.DataTable([
              ['type', 'code', 'title', 'nb_aids_available'],
              [
                'classique',
                '3',
                'Tester une **nouvelle recette végétarienne**',
                1
              ]
            ]));
        await iHaveActionDetailInMyLibrary(
            tester,
            const bdd.DataTable([
              [
                'id',
                'title',
                'subTitle',
                'how',
                'why',
                'service_id',
                'service_category'
              ],
              [
                '3',
                'Tester une **nouvelle recette végétarienne**',
                'Faites des économies et le plein de vitamines ! Cette semaine, on cuisine une recette saine et délicieuse !',
                '# Nos astuces\n\n- **Revisitez vos classiques** : Lasagnes au légumes, chili sin carne, re-découvrez vos plats favoris en version végétariennes \n\n- **Protéines végétales** : Associez légumineuses (lentilles, pois chiches) et céréales (riz, quinoa) pour un plat complet.\n\n- **Variez les textures** : Alternez croquant (graines, noix) et fondant (avocats, patates douces)\n\n- **Épices et herbes** : Boostez les saveurs avec du curry, paprika fumé, curcuma, cumin ou herbes fraîches.',
                '# En quelques mots\n\n- Les repas à base de légumes sont en moyenne **30% moins chers** que ceux à base de viande.\n\n- Les nutriments contenus dans les légumes de saison sont une grande aide pour passer l’hiver !\n\n![test alt](https://agir-cms-prod.osc-secnum-fr1.scalingo.io/admin/70674f63fc3904c20de0.svg)',
                'recettes',
                'vegan'
              ]
            ]));
        await iTapOnTheMenuButton(tester);
        await iTapOn(tester, 'Actions');
        await iHaveRecipeServicesInMyLibrary(tester);
        await iHaveRecipeDetailInMyLibrary(
            tester,
            const bdd.DataTable([
              ['id', 'title', 'preparation_time'],
              ['1', 'Salade de pâtes complètes et lentilles', 5]
            ]));
        await iTapOn(tester, 'Tester une nouvelle recette végétarienne');
        await iScrollDownTo(tester, 'Salade de pâtes complètes et lentilles');
        await iTapOn(tester, 'Salade de pâtes complètes et lentilles');
        await iSee(tester, 'Temps de préparation : 5 min');
        await iSee(tester, '© Santé publique France');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''See recipe detail''',
          success,
        );
      }
    });
    testWidgets('''See recipes''', (tester) async {
      var success = true;
      try {
        await beforeEach('''See recipes''');
        await bddSetUp(tester);
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
        await iTapOnText(tester, 1, '🍛 Me nourrir');
        await iSee(tester, 'Les recettes de septembre');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''See recipes''',
          success,
        );
      }
    });
  });
}
