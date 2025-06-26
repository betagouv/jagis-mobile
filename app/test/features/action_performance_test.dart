// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_have_actions_in_my_library.dart';
import './step/i_am_logged_in.dart';
import './step/the_api_will_return.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_tap_on.dart';
import './step/i_see.dart';
import './step/i_scroll_down_to.dart';
import './step/the_api_receives.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Action Performance''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iHaveActionsInMyLibrary(
          tester,
          const bdd.DataTable([
            ['type', 'code', 'title', 'nb_aids_available'],
            [
              'bilan',
              'action_bilan_alimentation',
              'Calculer les impacts liés à **votre alimentation**',
              2
            ]
          ]));
      await iAmLoggedIn(tester);
      await theApiWillReturn(
          tester,
          const bdd.DataTable([
            ['method', 'path', 'statusCode', 'responseData'],
            [
              'GET',
              '/utilisateurs/{userId}/actions/bilan/action_bilan_alimentation',
              200,
              {
                "nombre_actions_en_cours": 0,
                "nombre_actions_faites": 0,
                "nombre_aides_disponibles": 0,
                "code": "action_bilan_alimentation",
                "titre": "Calculer les impacts liés à **votre alimentation**",
                "sous_titre":
                    "Quelques questions pour mieux comprendre vos habitudes et calculer le bilan carbone de votre alimentation",
                "consigne":
                    "Réalisez cette action dans les prochaines semaines et partagez vos retours",
                "label_compteur": "**453 actions** réalisées par la communauté",
                "besoins": [],
                "comment": null,
                "pourquoi": null,
                "type": "bilan",
                "thematique": "alimentation",
                "quizzes": [],
                "aides": [],
                "services": [],
                "nom_commune": "Bordeaux",
                "quizz_felicitations": null,
                "deja_vue": true,
                "deja_faite": false,
                "faqs": [],
                "points": 50,
                "sources": [],
                "articles": [],
                "like_level": null,
                "enchainement_id": "bilan_action_bilan_alimentation",
                "explications_recommandation": {
                  "liste_explications": [],
                  "est_exclu": false
                },
                "explications_recommandation_raw": {"liste_explications": []}
              }
            ],
            [
              'GET',
              '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/bilan_action_bilan_alimentation/first',
              200,
              {
                "nombre_total_questions": 2,
                "nombre_total_questions_effectives": 2,
                "position_courante": 1,
                "question_courante": {
                  "code": "KYC_alimentation_regime",
                  "question": "Quel est votre régime alimentaire habituel",
                  "reponse_multiple": [
                    {
                      "code": "chaque_jour_viande",
                      "label": "Viande chaque jour",
                      "selected": false
                    },
                    {
                      "code": "peu_viande",
                      "label": "Peu de viande",
                      "selected": false
                    },
                    {
                      "code": "vegetarien",
                      "label": "Végétarien",
                      "selected": false
                    },
                    {
                      "code": "vegetalien",
                      "label": "Végétalien",
                      "selected": false
                    }
                  ],
                  "is_answered": false,
                  "categorie": "mission",
                  "points": 5,
                  "type": "choix_unique",
                  "is_NGC": false,
                  "thematique": "alimentation"
                },
                "is_first": true,
                "is_last": false,
                "is_out_of_range": false
              }
            ],
            [
              'GET',
              '/utilisateurs/{userId}/questionsKYC_v2/KYC_alimentation_regime',
              200,
              {
                "code": "KYC_alimentation_regime",
                "question": "Quel est votre régime alimentaire habituel",
                "reponse_multiple": [
                  {
                    "code": "chaque_jour_viande",
                    "label": "Viande chaque jour",
                    "selected": false
                  },
                  {
                    "code": "peu_viande",
                    "label": "Peu de viande",
                    "selected": false
                  },
                  {
                    "code": "vegetarien",
                    "label": "Végétarien",
                    "selected": false
                  },
                  {
                    "code": "vegetalien",
                    "label": "Végétalien",
                    "selected": false
                  }
                ],
                "is_answered": false,
                "categorie": "mission",
                "points": 5,
                "type": "choix_unique",
                "is_NGC": false,
                "thematique": "alimentation"
              }
            ],
            [
              'PUT',
              '/utilisateurs/{userId}/questionsKYC_v2/KYC_alimentation_regime',
              200,
              {}
            ],
            [
              'GET',
              '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/bilan_action_bilan_alimentation/following/KYC_alimentation_regime',
              200,
              {
                "nombre_total_questions": 2,
                "nombre_total_questions_effectives": 2,
                "position_courante": 2,
                "question_courante": {
                  "code": "KYC_petitdej",
                  "question": "Quel petit déjeuner vous correspond le plus ?",
                  "reponse_multiple": [
                    {
                      "code": "pain",
                      "label": " Viennoiserie et pain",
                      "selected": false
                    },
                    {
                      "code": "lait",
                      "label": "Lait et céréales",
                      "selected": false
                    },
                    {
                      "code": "bacon",
                      "label": "Salé (type britannique, bacon et oeuf)",
                      "selected": false
                    },
                    {"code": "fruit", "label": "Fruits", "selected": false},
                    {
                      "code": "aucun",
                      "label": "Pas de petit-dej'",
                      "selected": false
                    }
                  ],
                  "is_answered": false,
                  "categorie": "mission",
                  "points": 5,
                  "type": "choix_unique",
                  "is_NGC": true,
                  "thematique": "alimentation"
                },
                "is_first": false,
                "is_last": false,
                "is_out_of_range": false
              }
            ],
            [
              'GET',
              '/utilisateurs/{userId}/questionsKYC_v2/KYC_petitdej',
              200,
              {
                "code": "KYC_petitdej",
                "question": "Quel petit déjeuner vous correspond le plus ?",
                "reponse_multiple": [
                  {
                    "code": "pain",
                    "label": " Viennoiserie et pain",
                    "selected": false
                  },
                  {
                    "code": "lait",
                    "label": "Lait et céréales",
                    "selected": false
                  },
                  {
                    "code": "bacon",
                    "label": "Salé (type britannique, bacon et oeuf)",
                    "selected": false
                  },
                  {"code": "fruit", "label": "Fruits", "selected": false},
                  {
                    "code": "aucun",
                    "label": "Pas de petit-dej'",
                    "selected": false
                  }
                ],
                "is_answered": false,
                "categorie": "mission",
                "points": 5,
                "type": "choix_unique",
                "is_NGC": true,
                "thematique": "alimentation"
              }
            ],
            [
              'PUT',
              '/utilisateurs/{userId}/questionsKYC_v2/KYC_petitdej',
              200,
              {}
            ],
            [
              'GET',
              '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/bilan_action_bilan_alimentation/following/KYC_petitdej',
              200,
              {
                "nombre_total_questions": 2,
                "nombre_total_questions_effectives": 2,
                "position_courante": -1,
                "is_first": false,
                "is_last": false,
                "is_out_of_range": false
              }
            ],
            [
              "POST",
              "/utilisateurs/{userId}/actions/bilan/action_bilan_alimentation/faite",
              200,
              {}
            ],
            [
              "GET",
              "/utilisateurs/{userId}/bilans/last_v3/alimentation",
              200,
              {
                "thematique": "alimentation",
                "impact_kg_annee": 3873.1151821000003,
                "details": [
                  {
                    "label": "Viandes",
                    "impact_kg_annee": 2233.296,
                    "emoji": "🥩"
                  },
                  {
                    "label": "Boissons",
                    "impact_kg_annee": 940.1798000000001,
                    "emoji": "🥤"
                  },
                  {"label": "Poissons", "impact_kg_annee": 182, "emoji": "🐟"},
                  {
                    "label": "Petit déjeuner",
                    "impact_kg_annee": 113.15,
                    "emoji": "🥐"
                  },
                  {
                    "label": "Fruits & Légumes",
                    "impact_kg_annee": 0,
                    "emoji": "🥦"
                  }
                ],
                "emoji": "🍴"
              }
            ]
          ]));
      await theApplicationIsLaunched(tester);
      await iTapOnTheMenuButton(tester);
      await iTapOn(tester, 'Actions');
      await iTapOn(tester, 'Calculer les impacts liés à votre alimentation');
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Voir la première question''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Voir la première question''');
        await bddSetUp(tester);
        await iSee(tester, 'Quel est votre régime alimentaire habituel');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir la première question''',
          success,
        );
      }
    });
    testWidgets('''Répond aux questions''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Répond aux questions''');
        await bddSetUp(tester);
        await iTapOn(tester, 'Peu de viande');
        await iScrollDownTo(tester, 'Question suivante');
        await iTapOn(tester, 'Question suivante');
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'PUT',
                '/utilisateurs/{userId}/questionsKYC_v2/KYC_alimentation_regime',
                200,
                [
                  {"code": "chaque_jour_viande", "selected": false},
                  {"code": "peu_viande", "selected": true},
                  {"code": "vegetarien", "selected": false},
                  {"code": "vegetalien", "selected": false}
                ]
              ]
            ]));
        await iScrollDownTo(tester, 'Viennoiserie et pain');
        await iTapOn(tester, 'Viennoiserie et pain');
        await iScrollDownTo(tester, 'Question suivante');
        await iTapOn(tester, 'Question suivante');
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'PUT',
                "/utilisateurs/{userId}/questionsKYC_v2/KYC_petitdej",
                200,
                [
                  {"code": "pain", "selected": true},
                  {"code": "lait", "selected": false},
                  {"code": "bacon", "selected": false},
                  {"code": "fruit", "selected": false},
                  {"code": "aucun", "selected": false}
                ]
              ],
              [
                'POST',
                "/utilisateurs/{userId}/actions/bilan/action_bilan_alimentation/faite",
                200,
                null
              ]
            ]));
        await iSee(tester, 'Votre bilan alimentation');
        await iSee(tester, 'Viandes');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Répond aux questions''',
          success,
        );
      }
    });
    testWidgets('''Recommencer le bilan''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Recommencer le bilan''');
        await bddSetUp(tester);
        await iTapOn(tester, 'Peu de viande');
        await iScrollDownTo(tester, 'Question suivante');
        await iTapOn(tester, 'Question suivante');
        await iScrollDownTo(tester, 'Viennoiserie et pain');
        await iTapOn(tester, 'Viennoiserie et pain');
        await iScrollDownTo(tester, 'Question suivante');
        await iTapOn(tester, 'Question suivante');
        await iSee(tester, 'Votre bilan alimentation');
        await iScrollDownTo(tester, 'Recommmencer le bilan');
        await iTapOn(tester, 'Recommmencer le bilan');
        await iSee(tester, 'Question 1 sur 2');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Recommencer le bilan''',
          success,
        );
      }
    });
  });
}
