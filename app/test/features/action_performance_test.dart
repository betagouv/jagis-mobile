// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_have_actions_in_my_library.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/the_api_will_return.dart';
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
      await theApplicationIsLaunched(tester);
      await iTapOnTheMenuButton(tester);
      await theApiWillReturn(
          tester,
          const bdd.DataTable([
            ['method', 'path', 'statusCode', 'responseData'],
            [
              'GET',
              '/utilisateurs/{userId}/actions/bilan/action_bilan_alimentation',
              200,
              {
                "nombre_actions_en_cours": 3,
                "nombre_actions_faites": 3,
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
                "kycs": [
                  {
                    "code": "KYC_saison_frequence",
                    "question":
                        "Faites-vous attention à consommer des fruits et légumes de saison ?",
                    "reponse_multiple": [
                      {"code": "jamais", "label": "Jamais", "selected": true},
                      {
                        "code": "parfois",
                        "label": "Parfois",
                        "selected": false
                      },
                      {
                        "code": "souvent",
                        "label": "Souvent",
                        "selected": false
                      },
                      {
                        "code": "toujours",
                        "label": "Toujours",
                        "selected": false
                      }
                    ],
                    "is_answered": true,
                    "categorie": "mission",
                    "points": 5,
                    "type": "choix_unique",
                    "is_NGC": true,
                    "thematique": "alimentation"
                  },
                  {
                    "code": "KYC_gaspillage_alimentaire_frequence",
                    "question":
                        "Combien estimez-vous la quantité de déchets alimentaires que vous jetez ?",
                    "reponse_multiple": [
                      {
                        "code": "50L",
                        "label": "Une poubelle de 50L par semaine",
                        "selected": true
                      },
                      {
                        "code": "20L",
                        "label": "Une poubelle de 20L par semaine",
                        "selected": false
                      },
                      {
                        "code": "peu",
                        "label":
                            "Environ une poignée ou l'équivalent d'un bol par semaine",
                        "selected": false
                      },
                      {"code": "zero", "label": "Zéro", "selected": false},
                      {
                        "code": "ne_sais_pas",
                        "label": "Je ne sais pas",
                        "selected": false
                      }
                    ],
                    "is_answered": true,
                    "categorie": "mission",
                    "points": 5,
                    "type": "choix_unique",
                    "is_NGC": true,
                    "thematique": "alimentation"
                  }
                ],
                "quizzes": [],
                "aides": [],
                "services": [],
                "nom_commune": "Dole",
                "quizz_felicitations": null,
                "deja_vue": true,
                "deja_faite": true,
                "faqs": [],
                "points": 50,
                "sources": []
              }
            ],
            [
              'GET',
              '/utilisateurs/{userId}/questionsKYC_v2/KYC_saison_frequence',
              200,
              {
                "code": "KYC_saison_frequence",
                "question":
                    "Faites-vous attention à consommer des fruits et légumes de saison ?",
                "reponse_multiple": [
                  {"code": "jamais", "label": "Jamais", "selected": false},
                  {"code": "parfois", "label": "Parfois", "selected": false},
                  {"code": "souvent", "label": "Souvent", "selected": false},
                  {"code": "toujours", "label": "Toujours", "selected": false}
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
              "PUT",
              "/utilisateurs/{userId}/questionsKYC_v2/KYC_saison_frequence",
              200,
              {}
            ],
            [
              'GET',
              '/utilisateurs/{userId}/questionsKYC_v2/KYC_gaspillage_alimentaire_frequence',
              200,
              {
                "code": "KYC_gaspillage_alimentaire_frequence",
                "question":
                    "Combien estimez-vous la quantité de déchets alimentaires que vous jetez ?",
                "reponse_multiple": [
                  {
                    "code": "50L",
                    "label": "Une poubelle de 50L par semaine",
                    "selected": true
                  },
                  {
                    "code": "20L",
                    "label": "Une poubelle de 20L par semaine",
                    "selected": false
                  },
                  {
                    "code": "peu",
                    "label":
                        "Environ une poignée ou l'équivalent d'un bol par semaine",
                    "selected": false
                  },
                  {"code": "zero", "label": "Zéro", "selected": false},
                  {
                    "code": "ne_sais_pas",
                    "label": "Je ne sais pas",
                    "selected": false
                  }
                ],
                "is_answered": true,
                "categorie": "mission",
                "points": 5,
                "type": "choix_unique",
                "is_NGC": true,
                "thematique": "alimentation"
              }
            ],
            [
              "PUT",
              "/utilisateurs/{userId}/questionsKYC_v2/KYC_gaspillage_alimentaire_frequence",
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
            ],
            [
              "POST",
              "/utilisateurs/{userId}/actions/bilan/action_bilan_alimentation/faite",
              200,
              {}
            ]
          ]));
      await iTapOn(tester, 'Actions');
      await iTapOn(
          tester, 'Bilan - Calculer les impacts liés à votre alimentation');
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
        await iSee(tester,
            'Faites-vous attention à consommer des fruits et légumes de saison ?');
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
        await iTapOn(tester, 'Jamais');
        await iScrollDownTo(tester, 'Question suivante');
        await iTapOn(tester, 'Question suivante');
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                "PUT",
                "/utilisateurs/{userId}/questionsKYC_v2/KYC_saison_frequence",
                200,
                [
                  {"code": "jamais", "selected": true},
                  {"code": "parfois", "selected": false},
                  {"code": "souvent", "selected": false},
                  {"code": "toujours", "selected": false}
                ]
              ]
            ]));
        await iTapOn(tester, 'Une poubelle de 50L par semaine');
        await iScrollDownTo(tester, 'Question suivante');
        await iTapOn(tester, 'Question suivante');
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                "PUT",
                "/utilisateurs/{userId}/questionsKYC_v2/KYC_gaspillage_alimentaire_frequence",
                200,
                [
                  {"code": "50L", "selected": true},
                  {"code": "20L", "selected": false},
                  {"code": "peu", "selected": false},
                  {"code": "zero", "selected": false},
                  {"code": "ne_sais_pas", "selected": false}
                ]
              ],
              [
                "POST",
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
        await iTapOn(tester, 'Jamais');
        await iScrollDownTo(tester, 'Question suivante');
        await iTapOn(tester, 'Question suivante');
        await iTapOn(tester, 'Une poubelle de 50L par semaine');
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
