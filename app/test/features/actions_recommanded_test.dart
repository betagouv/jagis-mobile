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
import './step/i_see.dart';
import './step/i_scroll_down_to.dart';
import './step/i_tap_on.dart';
import './step/i_have_theme_with_actions.dart';
import './step/the_api_receives.dart';
import './step/i_have_theme_with_no_action.dart';
import './step/i_have_theme_with_customization_needed.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Mes actions recommandées''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
      await theApiWillReturn(
          tester,
          const bdd.DataTable([
            ['method', 'path', 'statusCode', 'responseData'],
            [
              'GET',
              '/utilisateurs/%7BuserId%7D/aides_v2?thematique=transport',
              200,
              {"couverture_aides_ok": false, "liste_aides": []}
            ],
            [
              'GET',
              '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/ENCHAINEMENT_KYC_personnalisation_transport/first',
              200,
              {
                "nombre_total_questions": 3,
                "nombre_total_questions_effectives": 3,
                "position_courante": 2,
                "question_courante": {
                  "code": "KYC003",
                  "question": "Êtes-vous équipé(e) d’un vélo ?",
                  "reponse_multiple": [
                    {"code": "oui", "label": "Oui", "selected": false},
                    {"code": "non", "label": "Non", "selected": false}
                  ],
                  "is_answered": false,
                  "categorie": "mission",
                  "points": 5,
                  "type": "choix_unique",
                  "is_NGC": false,
                  "thematique": "transport"
                },
                "is_first": false,
                "is_last": false,
                "is_out_of_range": false
              }
            ],
            [
              'GET',
              '/utilisateurs/{userId}/questionsKYC_v2/KYC003',
              200,
              {
                "code": "KYC003",
                "question": "Êtes-vous équipé(e) d’un vélo ?",
                "reponse_multiple": [
                  {"code": "oui", "label": "Oui", "selected": false},
                  {"code": "non", "label": "Non", "selected": false}
                ],
                "is_answered": false,
                "categorie": "mission",
                "points": 5,
                "type": "choix_unique",
                "is_NGC": false,
                "thematique": "transport"
              }
            ],
            ["PUT", '/utilisateurs/{userId}/questionsKYC_v2/KYC003', 200, {}],
            [
              'POST',
              '/utilisateurs/{userId}/questionsKYC_v2/KYC003/skip',
              200,
              {}
            ],
            [
              'GET',
              '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/ENCHAINEMENT_KYC_personnalisation_transport/following/KYC003',
              200,
              {
                "nombre_total_questions": 3,
                "nombre_total_questions_effectives": 3,
                "position_courante": 3,
                "question_courante": {
                  "code": "KYC_possede_voiture_oui_non",
                  "question": "Possédez-vous une voiture ?",
                  "reponse_multiple": [
                    {"code": "oui", "label": "Oui", "selected": false},
                    {"code": "non", "label": "Non", "selected": false}
                  ],
                  "is_answered": false,
                  "categorie": "recommandation",
                  "points": 5,
                  "type": "choix_unique",
                  "is_NGC": false,
                  "thematique": "transport"
                },
                "is_first": false,
                "is_last": true,
                "is_out_of_range": false
              }
            ],
            [
              'GET',
              '/utilisateurs/{userId}/questionsKYC_v2/KYC_possede_voiture_oui_non',
              200,
              {
                "code": "KYC_possede_voiture_oui_non",
                "question": "Possédez-vous une voiture ?",
                "reponse_multiple": [
                  {"code": "oui", "label": "Oui", "selected": false},
                  {"code": "non", "label": "Non", "selected": false}
                ],
                "is_answered": false,
                "categorie": "recommandation",
                "points": 5,
                "type": "choix_unique",
                "is_NGC": false,
                "thematique": "transport"
              }
            ],
            [
              "PUT",
              '/utilisateurs/{userId}/questionsKYC_v2/KYC_possede_voiture_oui_non',
              200,
              {}
            ],
            [
              'GET',
              '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/ENCHAINEMENT_KYC_personnalisation_transport/following/KYC_possede_voiture_oui_non',
              200,
              {
                "nombre_total_questions": 3,
                "nombre_total_questions_effectives": 3,
                "position_courante": -1,
                "is_first": false,
                "is_last": true,
                "is_out_of_range": false
              }
            ]
          ]));
      await theApplicationIsLaunched(tester);
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Voir la popup si la personnalisation n'a pas été faite''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Voir la popup si la personnalisation n'a pas été faite''');
        await bddSetUp(tester);
        await iTapOnText(tester, 1, '🚅 Me déplacer');
        await iSee(tester, '3 questions pour…');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir la popup si la personnalisation n'a pas été faite''',
          success,
        );
      }
    });
    testWidgets('''Commencer les questions''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Commencer les questions''');
        await bddSetUp(tester);
        await iTapOnText(tester, 1, '🚅 Me déplacer');
        await iScrollDownTo(tester, 'Commencer');
        await iTapOn(tester, 'Commencer');
        await iSee(tester, "Êtes-vous équipé(e) d’un vélo ?");
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Commencer les questions''',
          success,
        );
      }
    });
    testWidgets('''Répondre à toutes les questions''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Répondre à toutes les questions''');
        await bddSetUp(tester);
        await iTapOnText(tester, 1, '🚅 Me déplacer');
        await iScrollDownTo(tester, 'Commencer');
        await iTapOn(tester, 'Commencer');
        await iTapOn(tester, 'Non');
        await iTapOn(tester, "Question suivante");
        await iTapOn(tester, 'Non');
        await iHaveThemeWithActions(tester);
        await iTapOn(tester, "Question suivante");
        await iSee(
            tester, 'Trouver le type de voiture qui vous convient le mieux');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Répondre à toutes les questions''',
          success,
        );
      }
    });
    testWidgets('''Passez une question''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Passez une question''');
        await bddSetUp(tester);
        await iTapOnText(tester, 1, '🚅 Me déplacer');
        await iScrollDownTo(tester, 'Commencer');
        await iTapOn(tester, 'Commencer');
        await iTapOn(tester, "Passer la question");
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'POST',
                '/utilisateurs/{userId}/questionsKYC_v2/KYC003/skip',
                200,
                null
              ]
            ]));
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Passez une question''',
          success,
        );
      }
    });
    testWidgets('''Refaire le questionnaire''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Refaire le questionnaire''');
        await bddSetUp(tester);
        await iHaveThemeWithNoAction(tester);
        await iTapOnText(tester, 1, '🚅 Me déplacer');
        await iHaveThemeWithCustomizationNeeded(tester);
        await iScrollDownTo(tester, 'Refaire');
        await iTapOn(tester, 'Refaire');
        await iSee(tester, '3 questions pour…');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Refaire le questionnaire''',
          success,
        );
      }
    });
  });
}
