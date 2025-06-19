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

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Action Winter''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
      await theApiWillReturn(
          tester,
          const bdd.DataTable([
            ['method', 'path', 'statusCode', 'responseData'],
            [
              'GET',
              '/utilisateurs/%7BuserId%7D/actions',
              200,
              {
                "actions": [
                  {
                    "nombre_actions_en_cours": 0,
                    "nombre_actions_faites": 0,
                    "nombre_aides_disponibles": 0,
                    "code": "action_simulateur_winter",
                    "titre": "**Faire des économies sur ma facture d’énergie**",
                    "type": "simulateur",
                    "thematique": "logement",
                    "deja_vue": true,
                    "deja_faite": false,
                    "points": 30
                  }
                ],
                "filtres": [
                  {
                    "code": "alimentation",
                    "label": "🥦 Alimentation",
                    "selected": false
                  },
                  {
                    "code": "transport",
                    "label": "🚗 Transports",
                    "selected": false
                  },
                  {
                    "code": "logement",
                    "label": "🏡 Logement",
                    "selected": false
                  },
                  {
                    "code": "consommation",
                    "label": "🛒 Consommation durable",
                    "selected": false
                  },
                  {
                    "code": "climat",
                    "label": "☀️ Environnement",
                    "selected": false
                  },
                  {"code": "dechet", "label": "🗑️ Déchets", "selected": false},
                  {"code": "loisir", "label": "⚽ Loisirs", "selected": false}
                ],
                "consultation": "tout",
                "realisation": "tout",
                "nombre_resultats": 39,
                "nombre_resultats_disponibles": 39
              }
            ]
          ]));
      await theApplicationIsLaunched(tester);
      await iTapOnTheMenuButton(tester);
      await iTapOn(tester, 'Actions');
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Connexion établie''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Connexion établie''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/actions/simulateur/action_simulateur_winter',
                200,
                {
                  "nombre_actions_en_cours": 1,
                  "nombre_actions_faites": 1,
                  "nombre_aides_disponibles": 0,
                  "code": "action_simulateur_winter",
                  "titre": "**Faire des économies sur ma facture d’énergie**",
                  "sous_titre": null,
                  "consigne":
                      "Réalisez cette action dans les prochaines semaines et partagez vos retours",
                  "label_compteur":
                      "**453 actions** réalisées par la communauté",
                  "besoins": [],
                  "comment": null,
                  "pourquoi":
                      "## En quelques mots\n\nObtenez la répartition de votre consommation d'énergie en plus d’actions personnalisées pour réduire votre facture d’électricité sans sacrifier votre confort.",
                  "type": "simulateur",
                  "thematique": "logement",
                  "kycs": [
                    {
                      "code": "KYC_alimentation_achat_vrac",
                      "question": "Achetez-vous en vrac ?",
                      "reponse_multiple": [
                        {"code": "oui", "label": "Oui", "selected": false},
                        {"code": "non", "label": "Non", "selected": true},
                        {
                          "code": "ne_sais_pas",
                          "label": "Je ne sais pas",
                          "selected": false
                        }
                      ],
                      "is_answered": true,
                      "categorie": "test",
                      "points": 5,
                      "type": "choix_unique",
                      "is_NGC": true,
                      "thematique": "alimentation"
                    },
                    {
                      "code": "KYC_appetence_cuisine",
                      "question": "Aimez-vous cuisiner ?",
                      "reponse_multiple": [
                        {"code": "oui", "label": "Oui", "selected": false},
                        {
                          "code": "parfois",
                          "label": "De temps en temps",
                          "selected": false
                        },
                        {"code": "non", "label": "Non", "selected": false},
                        {
                          "code": "pas_de_reponse",
                          "label": "Je ne souhaite pas répondre",
                          "selected": false
                        }
                      ],
                      "is_answered": false,
                      "categorie": "recommandation",
                      "points": 5,
                      "type": "choix_unique",
                      "is_NGC": false,
                      "thematique": "alimentation"
                    }
                  ],
                  "quizzes": [],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Lyon",
                  "quizz_felicitations": null,
                  "deja_vue": true,
                  "deja_faite": false,
                  "faqs": [],
                  "points": 30,
                  "sources": [],
                  "articles": [],
                  "like_level": null,
                  "enchainement_id": "simulateur_action_simulateur_winter",
                  "explications_recommandation": {
                    "liste_explications": [],
                    "est_exclu": false
                  },
                  "explications_recommandation_raw": {"liste_explications": []}
                }
              ],
              [
                'GET',
                '/utilisateurs/{userId}/logement',
                200,
                {
                  "nombre_adultes": 2,
                  "nombre_enfants": 1,
                  "latitude": 47.10341,
                  "longitude": 5.480833,
                  "numero_rue": "5",
                  "rue": "Chemin de Rougemont",
                  "code_postal": "39100",
                  "commune": "DOLE",
                  "type": "maison",
                  "superficie": "superficie_150",
                  "proprietaire": null,
                  "chauffage": null,
                  "plus_de_15_ans": true,
                  "dpe": null,
                  "commune_label": "Dole",
                  "code_commune": "39198"
                }
              ]
            ]));
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Connexion établie''',
          success,
        );
      }
    });
  });
}
