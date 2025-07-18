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
import './step/i_see.dart';
import './step/i_scroll_down_to.dart';
import './step/i_enter_in_the_field.dart';
import './step/the_api_receives.dart';
import './step/i_dont_see.dart';

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
                    "emoji": "🌧️",
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

    testWidgets('''S'incrire par l'adresse et la connexion est établie''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''S'incrire par l'adresse et la connexion est établie''');
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
                  "emoji": "🌧️",
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
              ],
              [
                'POST',
                '/utilisateurs/{userId}/winter/inscription_par_adresse',
                200,
                {}
              ]
            ]));
        await iTapOn(
            tester, '🌧️ Faire des économies sur ma facture d’énergie');
        await iSee(tester, 'Réduisez jusqu’à 25% votre facture d’énergie');
        await iScrollDownTo(tester, 'Commencer');
        await iTapOn(tester, 'Commencer');
        await iEnterInTheField(tester, 'Saudon',
            'Nom de famille (du titulaire du contrat électrique)');
        await iScrollDownTo(tester, 'Valider');
        await iTapOn(tester,
            'En activant le suivi de ma consommation, je déclare sur l’honneur être titulaire du compte électrique ou être mandaté par celui-ci. J’autorise Watt Watchers à recueillir mon historique de consommation d’électricité sur 3 ans (demi-heure, journée et puissance maximum quotidienne), ainsi qu’à analyser mes consommations.');
        await iTapOn(tester, 'Valider');
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'POST',
                "/utilisateurs/{userId}/winter/inscription_par_adresse",
                200,
                {
                  'nom': 'Saudon',
                  'adresse': '5 Chemin de Rougemont',
                  'code_postal': '39100',
                  'code_commune': '39198'
                }
              ]
            ]));
        await iSee(tester, 'Connexion établie');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''S'incrire par l'adresse et la connexion est établie''',
          success,
        );
      }
    });
    testWidgets('''S'incrire par l'adresse et la connexion a échoué''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''S'incrire par l'adresse et la connexion a échoué''');
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
                  "emoji": "🌧️",
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
              ],
              [
                'POST',
                '/utilisateurs/{userId}/winter/inscription_par_adresse',
                400,
                {}
              ]
            ]));
        await iTapOn(
            tester, '🌧️ Faire des économies sur ma facture d’énergie');
        await iScrollDownTo(tester, 'Commencer');
        await iTapOn(tester, 'Commencer');
        await iEnterInTheField(tester, 'Saudon',
            'Nom de famille (du titulaire du contrat électrique)');
        await iScrollDownTo(tester, 'Valider');
        await iTapOn(tester,
            'En activant le suivi de ma consommation, je déclare sur l’honneur être titulaire du compte électrique ou être mandaté par celui-ci. J’autorise Watt Watchers à recueillir mon historique de consommation d’électricité sur 3 ans (demi-heure, journée et puissance maximum quotidienne), ainsi qu’à analyser mes consommations.');
        await iTapOn(tester, 'Valider');
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'POST',
                "/utilisateurs/{userId}/winter/inscription_par_adresse",
                400,
                {
                  'nom': 'Saudon',
                  'adresse': '5 Chemin de Rougemont',
                  'code_postal': '39100',
                  'code_commune': '39198'
                }
              ]
            ]));
        await iSee(tester, 'La connexion a échoué');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''S'incrire par l'adresse et la connexion a échoué''',
          success,
        );
      }
    });
    testWidgets('''S'incrire par le prm et la connexion est établie''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''S'incrire par le prm et la connexion est établie''');
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
                  "emoji": "🌧️",
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
              ],
              [
                'POST',
                '/utilisateurs/{userId}/winter/inscription_par_prm',
                200,
                {}
              ]
            ]));
        await iTapOn(
            tester, '🌧️ Faire des économies sur ma facture d’énergie');
        await iSee(tester, 'Réduisez jusqu’à 25% votre facture d’énergie');
        await iScrollDownTo(tester, 'Commencer');
        await iTapOn(tester, 'Commencer');
        await iScrollDownTo(tester, 'Avec mon numéro de PRM');
        await iTapOn(tester, 'Avec mon numéro de PRM');
        await iEnterInTheField(tester, '21209261841110', 'Numéro de PRM');
        await iEnterInTheField(tester, 'Saudon',
            'Nom de famille (du titulaire du contrat électrique)');
        await iScrollDownTo(tester, 'Valider');
        await iTapOn(tester,
            'En activant le suivi de ma consommation, je déclare sur l’honneur être titulaire du compte électrique ou être mandaté par celui-ci. J’autorise Watt Watchers à recueillir mon historique de consommation d’électricité sur 3 ans (demi-heure, journée et puissance maximum quotidienne), ainsi qu’à analyser mes consommations.');
        await iTapOn(tester, 'Valider');
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'POST',
                "/utilisateurs/{userId}/winter/inscription_par_prm",
                200,
                {'nom': 'Saudon', 'prm': '21209261841110'}
              ]
            ]));
        await iSee(tester, 'Connexion établie');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''S'incrire par le prm et la connexion est établie''',
          success,
        );
      }
    });
    testWidgets(
        '''Après que la connexion a échoué, modifier un champ de relancer pas la popup''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Après que la connexion a échoué, modifier un champ de relancer pas la popup''');
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
                  "emoji": "🌧️",
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
              ],
              [
                'POST',
                '/utilisateurs/{userId}/winter/inscription_par_adresse',
                400,
                {}
              ]
            ]));
        await iTapOn(
            tester, '🌧️ Faire des économies sur ma facture d’énergie');
        await iScrollDownTo(tester, 'Commencer');
        await iTapOn(tester, 'Commencer');
        await iEnterInTheField(tester, 'Saudon',
            'Nom de famille (du titulaire du contrat électrique)');
        await iScrollDownTo(tester, 'Valider');
        await iTapOn(tester,
            'En activant le suivi de ma consommation, je déclare sur l’honneur être titulaire du compte électrique ou être mandaté par celui-ci. J’autorise Watt Watchers à recueillir mon historique de consommation d’électricité sur 3 ans (demi-heure, journée et puissance maximum quotidienne), ainsi qu’à analyser mes consommations.');
        await iTapOn(tester, 'Valider');
        await iTapOn(tester, 'Retour');
        await iTapOn(tester,
            'En activant le suivi de ma consommation, je déclare sur l’honneur être titulaire du compte électrique ou être mandaté par celui-ci. J’autorise Watt Watchers à recueillir mon historique de consommation d’électricité sur 3 ans (demi-heure, journée et puissance maximum quotidienne), ainsi qu’à analyser mes consommations.');
        await iDontSee(tester, 'La connexion a échoué');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Après que la connexion a échoué, modifier un champ de relancer pas la popup''',
          success,
        );
      }
    });
    testWidgets(
        '''Une fois la connexion établie, on voit la première question''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Une fois la connexion établie, on voit la première question''');
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
                  "emoji": "🌧️",
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
              ],
              [
                'POST',
                '/utilisateurs/{userId}/winter/inscription_par_adresse',
                200,
                {}
              ],
              [
                'GET',
                '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/simulateur_action_simulateur_winter/first',
                200,
                {
                  "nombre_total_questions": 2,
                  "nombre_total_questions_effectives": 2,
                  "position_courante": 1,
                  "question_courante": {
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
                    "is_answered": false,
                    "categorie": "test",
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
                '/utilisateurs/{userId}/questionsKYC_v2/KYC_alimentation_achat_vrac',
                200,
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
                  "is_answered": false,
                  "categorie": "test",
                  "points": 5,
                  "type": "choix_unique",
                  "is_NGC": false,
                  "thematique": "alimentation"
                }
              ]
            ]));
        await iTapOn(
            tester, '🌧️ Faire des économies sur ma facture d’énergie');
        await iScrollDownTo(tester, 'Commencer');
        await iTapOn(tester, 'Commencer');
        await iEnterInTheField(tester, 'Saudon',
            'Nom de famille (du titulaire du contrat électrique)');
        await iScrollDownTo(tester, 'Valider');
        await iTapOn(tester,
            'En activant le suivi de ma consommation, je déclare sur l’honneur être titulaire du compte électrique ou être mandaté par celui-ci. J’autorise Watt Watchers à recueillir mon historique de consommation d’électricité sur 3 ans (demi-heure, journée et puissance maximum quotidienne), ainsi qu’à analyser mes consommations.');
        await iTapOn(tester, 'Valider');
        await iTapOn(tester, 'Continuer');
        await iSee(tester, 'Achetez-vous en vrac ?');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Une fois la connexion établie, on voit la première question''',
          success,
        );
      }
    });
    testWidgets(
        '''Après avoir répondu à toutes les questions, on affiche le graphique''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Après avoir répondu à toutes les questions, on affiche le graphique''');
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
                  "emoji": "🌧️",
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
              ],
              [
                'POST',
                '/utilisateurs/{userId}/winter/inscription_par_adresse',
                200,
                {}
              ],
              [
                'GET',
                '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/simulateur_action_simulateur_winter/first',
                200,
                {
                  "nombre_total_questions": 2,
                  "nombre_total_questions_effectives": 2,
                  "position_courante": 1,
                  "question_courante": {
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
                    "is_answered": false,
                    "categorie": "test",
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
                '/utilisateurs/{userId}/questionsKYC_v2/KYC_alimentation_achat_vrac',
                200,
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
                  "is_answered": false,
                  "categorie": "test",
                  "points": 5,
                  "type": "choix_unique",
                  "is_NGC": false,
                  "thematique": "alimentation"
                }
              ],
              [
                'PUT',
                '/utilisateurs/{userId}/questionsKYC_v2/KYC_alimentation_achat_vrac',
                200,
                {}
              ],
              [
                'GET',
                '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/simulateur_action_simulateur_winter/following/KYC_alimentation_achat_vrac',
                200,
                {
                  "nombre_total_questions": 2,
                  "nombre_total_questions_effectives": 2,
                  "position_courante": 2,
                  "question_courante": {
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
                  },
                  "is_first": false,
                  "is_last": true,
                  "is_out_of_range": false
                }
              ],
              [
                'GET',
                '/utilisateurs/{userId}/questionsKYC_v2/KYC_appetence_cuisine',
                200,
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
              [
                'PUT',
                '/utilisateurs/{userId}/questionsKYC_v2/KYC_appetence_cuisine',
                200,
                {}
              ],
              [
                'GET',
                '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/simulateur_action_simulateur_winter/following/KYC_appetence_cuisine',
                200,
                {
                  "nombre_total_questions": 2,
                  "nombre_total_questions_effectives": 2,
                  "position_courante": 3,
                  "is_first": false,
                  "is_last": false,
                  "is_out_of_range": true
                }
              ],
              [
                'GET',
                '/utilisateurs/{userId}/winter/consommation',
                200,
                {
                  "consommation_totale_euros": 1234567,
                  "economies_possibles_euros": 3345,
                  "economies_realisees_euros": 0,
                  "nombre_actions_associees": 0,
                  "detail_usages": [
                    {
                      "eur": 130,
                      "percent": 15,
                      "type": "airConditioning",
                      "couleur": "00809D",
                      "emoji": "❄️"
                    },
                    {
                      "eur": 1000,
                      "percent": 20,
                      "type": "heating",
                      "couleur": "F3A26D",
                      "emoji": "🔥"
                    },
                    {
                      "eur": 453,
                      "percent": 10,
                      "type": "appliances",
                      "couleur": "FCECDD",
                      "emoji": "📠"
                    },
                    {
                      "eur": 200,
                      "percent": 7,
                      "type": "cooking",
                      "couleur": "FF7601",
                      "emoji": "🍕"
                    },
                    {
                      "eur": 220,
                      "percent": 8,
                      "type": "hotWater",
                      "couleur": "FCD8CD",
                      "emoji": "💧"
                    },
                    {
                      "eur": 120,
                      "percent": 5,
                      "type": "lighting",
                      "couleur": "FEEBF6",
                      "emoji": "💡"
                    },
                    {
                      "eur": 70,
                      "percent": 5,
                      "type": "mobility",
                      "couleur": "EBD6FB",
                      "emoji": "🚙"
                    },
                    {
                      "eur": 42,
                      "percent": 10,
                      "type": "multimedia",
                      "couleur": "748873",
                      "emoji": "🎮"
                    },
                    {
                      "eur": 987,
                      "percent": 15,
                      "type": "other",
                      "couleur": "D1A980",
                      "emoji": "❓"
                    },
                    {
                      "eur": 123,
                      "percent": 5,
                      "type": "swimmingPool",
                      "couleur": "E5E0D8",
                      "emoji": "🏊"
                    }
                  ]
                }
              ],
              [
                'GET',
                '/utilisateurs/{userId}/winter/actions',
                200,
                [
                  {
                    "action": {
                      "code": "chauffe_eau_temperature",
                      "type": "classique"
                    },
                    "montant_economies_euro": 12
                  }
                ]
              ],
              [
                'POST',
                '/utilisateurs/{userId}/actions/simulateur/action_simulateur_winter/faite',
                200,
                {}
              ]
            ]));
        await iTapOn(
            tester, '🌧️ Faire des économies sur ma facture d’énergie');
        await iScrollDownTo(tester, 'Commencer');
        await iTapOn(tester, 'Commencer');
        await iEnterInTheField(tester, 'Saudon',
            'Nom de famille (du titulaire du contrat électrique)');
        await iScrollDownTo(tester, 'Valider');
        await iTapOn(tester,
            'En activant le suivi de ma consommation, je déclare sur l’honneur être titulaire du compte électrique ou être mandaté par celui-ci. J’autorise Watt Watchers à recueillir mon historique de consommation d’électricité sur 3 ans (demi-heure, journée et puissance maximum quotidienne), ainsi qu’à analyser mes consommations.');
        await iTapOn(tester, 'Valider');
        await iTapOn(tester, 'Continuer');
        await iTapOn(tester, 'Oui');
        await iScrollDownTo(tester, 'Question suivante');
        await iTapOn(tester, 'Question suivante');
        await iScrollDownTo(tester, 'Oui');
        await iTapOn(tester, 'Oui');
        await iScrollDownTo(tester, 'Question suivante');
        await iTapOn(tester, 'Question suivante');
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'POST',
                '/utilisateurs/{userId}/actions/simulateur/action_simulateur_winter/faite',
                200,
                null
              ]
            ]));
        await iSee(tester, '1234567€');
        await iSee(tester, 'Découvrir 1 action');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Après avoir répondu à toutes les questions, on affiche le graphique''',
          success,
        );
      }
    });
    testWidgets(
        '''Lorsque l'action a déjà été faite alors on arrive directement sur la page du graphique''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Lorsque l'action a déjà été faite alors on arrive directement sur la page du graphique''');
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
                  "emoji": "🌧️",
                  "titre": "**Faire des économies** sur ma facture d’énergie",
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
                        {"code": "oui", "label": "Oui", "selected": true},
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
                      "is_answered": true,
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
                  "deja_faite": true,
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
                '/utilisateurs/{userId}/winter/consommation',
                200,
                {
                  "consommation_totale_euros": 1234567,
                  "economies_possibles_euros": 3345,
                  "economies_realisees_euros": 0,
                  "nombre_actions_associees": 0,
                  "detail_usages": [
                    {
                      "eur": 130,
                      "percent": 15,
                      "type": "airConditioning",
                      "couleur": "00809D",
                      "emoji": "❄️"
                    },
                    {
                      "eur": 1000,
                      "percent": 20,
                      "type": "heating",
                      "couleur": "F3A26D",
                      "emoji": "🔥"
                    },
                    {
                      "eur": 453,
                      "percent": 10,
                      "type": "appliances",
                      "couleur": "FCECDD",
                      "emoji": "📠"
                    },
                    {
                      "eur": 200,
                      "percent": 7,
                      "type": "cooking",
                      "couleur": "FF7601",
                      "emoji": "🍕"
                    },
                    {
                      "eur": 220,
                      "percent": 8,
                      "type": "hotWater",
                      "couleur": "FCD8CD",
                      "emoji": "💧"
                    },
                    {
                      "eur": 120,
                      "percent": 5,
                      "type": "lighting",
                      "couleur": "FEEBF6",
                      "emoji": "💡"
                    },
                    {
                      "eur": 70,
                      "percent": 5,
                      "type": "mobility",
                      "couleur": "EBD6FB",
                      "emoji": "🚙"
                    },
                    {
                      "eur": 42,
                      "percent": 10,
                      "type": "multimedia",
                      "couleur": "748873",
                      "emoji": "🎮"
                    },
                    {
                      "eur": 987,
                      "percent": 15,
                      "type": "other",
                      "couleur": "D1A980",
                      "emoji": "❓"
                    },
                    {
                      "eur": 123,
                      "percent": 5,
                      "type": "swimmingPool",
                      "couleur": "E5E0D8",
                      "emoji": "🏊"
                    }
                  ]
                }
              ],
              [
                'GET',
                '/utilisateurs/{userId}/winter/actions',
                200,
                [
                  {
                    "action": {
                      "code": "chauffe_eau_temperature",
                      "type": "classique"
                    },
                    "montant_economies_euro": 12
                  }
                ]
              ]
            ]));
        await iTapOn(
            tester, '🌧️ Faire des économies sur ma facture d’énergie');
        await iSee(tester, '1234567€');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Lorsque l'action a déjà été faite alors on arrive directement sur la page du graphique''',
          success,
        );
      }
    });
    testWidgets('''Pouvoir recommencer l'action''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Pouvoir recommencer l'action''');
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
                  "emoji": "🌧️",
                  "titre": "**Faire des économies** sur ma facture d’énergie",
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
                        {"code": "oui", "label": "Oui", "selected": true},
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
                      "is_answered": true,
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
                  "deja_faite": true,
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
                '/utilisateurs/{userId}/winter/consommation',
                200,
                {
                  "consommation_totale_euros": 1234567,
                  "economies_possibles_euros": 3345,
                  "economies_realisees_euros": 0,
                  "nombre_actions_associees": 0,
                  "detail_usages": [
                    {
                      "eur": 130,
                      "percent": 15,
                      "type": "airConditioning",
                      "couleur": "00809D",
                      "emoji": "❄️"
                    },
                    {
                      "eur": 1000,
                      "percent": 20,
                      "type": "heating",
                      "couleur": "F3A26D",
                      "emoji": "🔥"
                    },
                    {
                      "eur": 453,
                      "percent": 10,
                      "type": "appliances",
                      "couleur": "FCECDD",
                      "emoji": "📠"
                    },
                    {
                      "eur": 200,
                      "percent": 7,
                      "type": "cooking",
                      "couleur": "FF7601",
                      "emoji": "🍕"
                    },
                    {
                      "eur": 220,
                      "percent": 8,
                      "type": "hotWater",
                      "couleur": "FCD8CD",
                      "emoji": "💧"
                    },
                    {
                      "eur": 120,
                      "percent": 5,
                      "type": "lighting",
                      "couleur": "FEEBF6",
                      "emoji": "💡"
                    },
                    {
                      "eur": 70,
                      "percent": 5,
                      "type": "mobility",
                      "couleur": "EBD6FB",
                      "emoji": "🚙"
                    },
                    {
                      "eur": 42,
                      "percent": 10,
                      "type": "multimedia",
                      "couleur": "748873",
                      "emoji": "🎮"
                    },
                    {
                      "eur": 987,
                      "percent": 15,
                      "type": "other",
                      "couleur": "D1A980",
                      "emoji": "❓"
                    },
                    {
                      "eur": 123,
                      "percent": 5,
                      "type": "swimmingPool",
                      "couleur": "E5E0D8",
                      "emoji": "🏊"
                    }
                  ]
                }
              ],
              [
                'GET',
                '/utilisateurs/{userId}/winter/actions',
                200,
                [
                  {
                    "action": {
                      "code": "chauffe_eau_temperature",
                      "type": "classique"
                    },
                    "montant_economies_euro": 12
                  }
                ]
              ]
            ]));
        await iTapOn(
            tester, '🌧️ Faire des économies sur ma facture d’énergie');
        await iSee(tester, '1234567€');
        await iScrollDownTo(tester, 'Recommencer');
        await iTapOn(tester, 'Recommencer');
        await iSee(tester, 'Commencer');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Pouvoir recommencer l'action''',
          success,
        );
      }
    });
  });
}
