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
import './step/i_dont_see.dart';
import './step/i_see.dart';
import './step/the_api_receives.dart';
import './step/i_scroll_down_to.dart';
import './step/i_enter_in_the_autocomplete_field.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Action MAIF''', () {
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
                    "code": "action_simulateur_maif",
                    "titre":
                        "Connaître les risques naturels auxquels votre logement est exposé",
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

    testWidgets('''Voir le simulateur avec uniquement la commune renseignée''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Voir le simulateur avec uniquement la commune renseignée''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/actions/simulateur/action_simulateur_maif',
                200,
                {
                  "nombre_actions_en_cours": 3,
                  "nombre_actions_faites": 3,
                  "nombre_aides_disponibles": 1,
                  "code": "action_simulateur_maif",
                  "titre":
                      "Connaître les risques naturels auxquels votre logement est exposé",
                  "label_compteur":
                      "**453 simulations** réalisées par la communauté",
                  "besoins": [],
                  "comment": "",
                  "pourquoi":
                      "## En **quelques mots**\n\nChaque année, des milliers de logements subissent des sinistres liés à des aléas naturels.\n\nEn consultant les risques (inondations, mouvements de terrain, feux de forêt…), vous pouvez adapter vos travaux, souscrire une assurance adaptée et éviter des dégâts coûteux.",
                  "type": "simulateur",
                  "thematique": "logement",
                  "quizzes": [],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Dole",
                  "quizz_felicitations": null,
                  "deja_vue": true,
                  "deja_faite": false,
                  "faqs": [],
                  "points": 30,
                  "sources": [],
                  "articles": [],
                  "enchainement_id": "",
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
                'GET',
                '/utilisateurs/%7BuserId%7D/risques_commune?code_commune=39198',
                200,
                {
                  "code_commune": "39198",
                  "nom_commune": "Dole",
                  "nombre_catastrophes_naturels": 13,
                  "pourcentage_commune_risque_inondation": 21,
                  "pourcentage_commune_risque_secheresse_geotechnique": 100
                }
              ]
            ]));
        await iTapOn(tester,
            'Simulateur - Connaître les risques naturels auxquels votre logement est exposé');
        await iDontSee(tester, 'Vos risques');
        await iSee(tester, 'Les chiffres clés de Dole');
        await iSee(tester, '21%');
        await iSee(tester, '100%');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir le simulateur avec uniquement la commune renseignée''',
          success,
        );
      }
    });
    testWidgets('''Voir le simulateur avec une adresse complète''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Voir le simulateur avec une adresse complète''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/actions/simulateur/action_simulateur_maif',
                200,
                null,
                {
                  "nombre_actions_en_cours": 3,
                  "nombre_actions_faites": 3,
                  "nombre_aides_disponibles": 1,
                  "code": "action_simulateur_maif",
                  "titre":
                      "Connaître les risques naturels auxquels votre logement est exposé",
                  "label_compteur":
                      "**453 simulations** réalisées par la communauté",
                  "besoins": [],
                  "comment": "",
                  "pourquoi":
                      "## En **quelques mots**\n\nChaque année, des milliers de logements subissent des sinistres liés à des aléas naturels.\n\nEn consultant les risques (inondations, mouvements de terrain, feux de forêt…), vous pouvez adapter vos travaux, souscrire une assurance adaptée et éviter des dégâts coûteux.",
                  "type": "simulateur",
                  "thematique": "logement",
                  "quizzes": [],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Dole",
                  "quizz_felicitations": null,
                  "deja_vue": true,
                  "deja_faite": false,
                  "faqs": [],
                  "points": 30,
                  "sources": [],
                  "articles": [],
                  "enchainement_id": "",
                  "explications_recommandation": {
                    "liste_explications": [],
                    "est_exclu": false
                  },
                  "explications_recommandation_raw": {"liste_explications": []}
                }
              ],
              [
                'POST',
                "/utilisateurs/{userId}/actions/simulateur/action_simulateur_maif/faite",
                200,
                null,
                {}
              ],
              [
                'GET',
                '/utilisateurs/{userId}/logement',
                200,
                null,
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
                'GET',
                '/utilisateurs/%7BuserId%7D/risques_commune?code_commune=39198',
                200,
                null,
                {
                  "code_commune": "39198",
                  "nom_commune": "Dole",
                  "nombre_catastrophes_naturels": 13,
                  "pourcentage_commune_risque_inondation": 21,
                  "pourcentage_commune_risque_secheresse_geotechnique": 100
                }
              ],
              [
                'GET',
                '/utilisateurs/%7BuserId%7D/risques_adresse?latitude=47.10341&longitude=5.480833',
                200,
                null,
                [
                  {
                    "type_risque": "secheresse",
                    "niveau_risque": "fort",
                    "titre": "Risques de sécheresse"
                  },
                  {
                    "type_risque": "seisme",
                    "niveau_risque": "faible",
                    "titre": "Risques sismiques"
                  },
                  {
                    "type_risque": "inondation",
                    "niveau_risque": "tres_faible",
                    "titre": "Risques d'inondations"
                  },
                  {
                    "type_risque": "radon",
                    "niveau_risque": "faible",
                    "titre": "Risques d'exposition au radon"
                  },
                  {
                    "type_risque": "submersion",
                    "niveau_risque": "tres_faible",
                    "titre": "Risques de submersion"
                  },
                  {
                    "type_risque": "tempete",
                    "niveau_risque": "tres_faible",
                    "titre": "Risques de tempêtes"
                  },
                  {
                    "type_risque": "argile",
                    "niveau_risque": "moyen",
                    "titre": "Risques retrait-gonflement des sols argileux"
                  }
                ]
              ]
            ]));
        await iTapOn(tester,
            'Simulateur - Connaître les risques naturels auxquels votre logement est exposé');
        await iSee(tester, '5 Chemin de Rougemont 39100 Dole');
        await iDontSee(tester, 'Choisir comme adresse principale');
        await iSee(tester, 'Vos risques');
        await iSee(tester, 'Risques de sécheresse');
        await iDontSee(tester, "Risques d'inondations");
        await iSee(tester, 'Risques retrait-gonflement des sols argileux');
        await iSee(tester, 'Risques sismiques');
        await iSee(tester, "Risques d'exposition au radon");
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'POST',
                "/utilisateurs/{userId}/actions/simulateur/action_simulateur_maif/faite",
                200,
                null
              ]
            ]));
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir le simulateur avec une adresse complète''',
          success,
        );
      }
    });
    testWidgets(
        '''Modifier l'adresse sans la définir comme adresse principale''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Modifier l'adresse sans la définir comme adresse principale''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/actions/simulateur/action_simulateur_maif',
                200,
                null,
                {
                  "nombre_actions_en_cours": 3,
                  "nombre_actions_faites": 3,
                  "nombre_aides_disponibles": 1,
                  "code": "action_simulateur_maif",
                  "titre":
                      "Connaître les risques naturels auxquels votre logement est exposé",
                  "label_compteur":
                      "**453 simulations** réalisées par la communauté",
                  "besoins": [],
                  "comment": "",
                  "pourquoi":
                      "## En **quelques mots**\n\nChaque année, des milliers de logements subissent des sinistres liés à des aléas naturels.\n\nEn consultant les risques (inondations, mouvements de terrain, feux de forêt…), vous pouvez adapter vos travaux, souscrire une assurance adaptée et éviter des dégâts coûteux.",
                  "type": "simulateur",
                  "thematique": "logement",
                  "quizzes": [],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Dole",
                  "quizz_felicitations": null,
                  "deja_vue": true,
                  "deja_faite": false,
                  "faqs": [],
                  "points": 30,
                  "sources": [],
                  "articles": [],
                  "enchainement_id": "",
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
                null,
                {
                  "nombre_adultes": 2,
                  "nombre_enfants": 1,
                  "latitude": 47.10341,
                  "longitude": 5.480833,
                  "numero_voie": "5",
                  "nom_voie": "Chemin de Rougemont",
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
                'GET',
                '/utilisateurs/%7BuserId%7D/risques_commune?code_commune=39198',
                200,
                null,
                {
                  "code_commune": "39198",
                  "nom_commune": "Dole",
                  "nombre_catastrophes_naturels": 13,
                  "pourcentage_commune_risque_inondation": 21,
                  "pourcentage_commune_risque_secheresse_geotechnique": 100
                }
              ],
              [
                'GET',
                '/utilisateurs/%7BuserId%7D/risques_adresse?latitude=47.10341&longitude=5.480833',
                200,
                null,
                [
                  {
                    "type_risque": "secheresse",
                    "niveau_risque": "fort",
                    "titre": "Risques de sécheresse"
                  },
                  {
                    "type_risque": "seisme",
                    "niveau_risque": "faible",
                    "titre": "Risques sismiques"
                  },
                  {
                    "type_risque": "inondation",
                    "niveau_risque": "tres_faible",
                    "titre": "Risques d'inondations"
                  },
                  {
                    "type_risque": "radon",
                    "niveau_risque": "faible",
                    "titre": "Risques d'exposition au radon"
                  },
                  {
                    "type_risque": "submersion",
                    "niveau_risque": "tres_faible",
                    "titre": "Risques de submersion"
                  },
                  {
                    "type_risque": "tempete",
                    "niveau_risque": "tres_faible",
                    "titre": "Risques de tempêtes"
                  },
                  {
                    "type_risque": "argile",
                    "niveau_risque": "moyen",
                    "titre": "Risques retrait-gonflement des sols argileux"
                  }
                ]
              ]
            ]));
        await iTapOn(tester,
            'Simulateur - Connaître les risques naturels auxquels votre logement est exposé');
        await iScrollDownTo(tester, 'Choisissez une adresse');
        await iEnterInTheAutocompleteField(tester, "110 Rue Garibaldi");
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData', 'responseData'],
              [
                'GET',
                '/utilisateurs/%7BuserId%7D/risques_adresse?latitude=45.766368&longitude=4.850666',
                200,
                null,
                [
                  {
                    "type_risque": "secheresse",
                    "niveau_risque": "faible",
                    "titre": "Risques de sécheresse"
                  },
                  {
                    "type_risque": "seisme",
                    "niveau_risque": "faible",
                    "titre": "Risques sismiques"
                  },
                  {
                    "type_risque": "inondation",
                    "niveau_risque": "moyen",
                    "titre": "Risques d'inondations"
                  },
                  {
                    "type_risque": "radon",
                    "niveau_risque": "faible",
                    "titre": "Risques d'exposition au radon"
                  },
                  {
                    "type_risque": "submersion",
                    "niveau_risque": "tres_faible",
                    "titre": "Risques de submersion"
                  },
                  {
                    "type_risque": "tempete",
                    "niveau_risque": "tres_faible",
                    "titre": "Risques de tempêtes"
                  },
                  {
                    "type_risque": "argile",
                    "niveau_risque": "faible",
                    "titre": "Risques retrait-gonflement des sols argileux"
                  }
                ]
              ],
              [
                'GET',
                '/utilisateurs/%7BuserId%7D/risques_commune?code_commune=69386',
                200,
                null,
                {
                  "code_commune": "69386",
                  "nom_commune": "Lyon 6e Arrondissement",
                  "nombre_catastrophes_naturels": 20,
                  "pourcentage_commune_risque_inondation": 35,
                  "pourcentage_commune_risque_secheresse_geotechnique": 21
                }
              ]
            ]));
        await iTapOn(tester, '110 Rue Garibaldi 69006 Lyon');
        await iSee(tester, 'Les chiffres clés de Lyon');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Modifier l'adresse sans la définir comme adresse principale''',
          success,
        );
      }
    });
    testWidgets('''Modifier l'adresse comme adresse principale''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Modifier l'adresse comme adresse principale''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/actions/simulateur/action_simulateur_maif',
                200,
                null,
                {
                  "nombre_actions_en_cours": 3,
                  "nombre_actions_faites": 3,
                  "nombre_aides_disponibles": 1,
                  "code": "action_simulateur_maif",
                  "titre":
                      "Connaître les risques naturels auxquels votre logement est exposé",
                  "label_compteur":
                      "**453 simulations** réalisées par la communauté",
                  "besoins": [],
                  "comment": "",
                  "pourquoi":
                      "## En **quelques mots**\n\nChaque année, des milliers de logements subissent des sinistres liés à des aléas naturels.\n\nEn consultant les risques (inondations, mouvements de terrain, feux de forêt…), vous pouvez adapter vos travaux, souscrire une assurance adaptée et éviter des dégâts coûteux.",
                  "type": "simulateur",
                  "thematique": "logement",
                  "quizzes": [],
                  "aides": [],
                  "services": [],
                  "nom_commune": "Dole",
                  "quizz_felicitations": null,
                  "deja_vue": true,
                  "deja_faite": false,
                  "faqs": [],
                  "points": 30,
                  "sources": [],
                  "articles": [],
                  "enchainement_id": "",
                  "explications_recommandation": {
                    "liste_explications": [],
                    "est_exclu": false
                  },
                  "explications_recommandation_raw": {"liste_explications": []}
                }
              ],
              [
                'POST',
                "/utilisateurs/{userId}/actions/simulateur/action_simulateur_maif/faite",
                200,
                null,
                {}
              ],
              [
                'GET',
                '/utilisateurs/{userId}/logement',
                200,
                null,
                {
                  "nombre_adultes": 2,
                  "nombre_enfants": 1,
                  "latitude": 47.10341,
                  "longitude": 5.480833,
                  "numero_voie": "5",
                  "nom_voie": "Chemin de Rougemont",
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
                'GET',
                '/utilisateurs/%7BuserId%7D/risques_commune?code_commune=39198',
                200,
                null,
                {
                  "code_commune": "39198",
                  "nom_commune": "Dole",
                  "nombre_catastrophes_naturels": 13,
                  "pourcentage_commune_risque_inondation": 21,
                  "pourcentage_commune_risque_secheresse_geotechnique": 100
                }
              ],
              [
                'GET',
                '/utilisateurs/%7BuserId%7D/risques_adresse?latitude=47.10341&longitude=5.480833',
                200,
                null,
                [
                  {
                    "type_risque": "secheresse",
                    "niveau_risque": "fort",
                    "titre": "Risques de sécheresse"
                  },
                  {
                    "type_risque": "seisme",
                    "niveau_risque": "faible",
                    "titre": "Risques sismiques"
                  },
                  {
                    "type_risque": "inondation",
                    "niveau_risque": "tres_faible",
                    "titre": "Risques d'inondations"
                  },
                  {
                    "type_risque": "radon",
                    "niveau_risque": "faible",
                    "titre": "Risques d'exposition au radon"
                  },
                  {
                    "type_risque": "submersion",
                    "niveau_risque": "tres_faible",
                    "titre": "Risques de submersion"
                  },
                  {
                    "type_risque": "tempete",
                    "niveau_risque": "tres_faible",
                    "titre": "Risques de tempêtes"
                  },
                  {
                    "type_risque": "argile",
                    "niveau_risque": "moyen",
                    "titre": "Risques retrait-gonflement des sols argileux"
                  }
                ]
              ]
            ]));
        await iTapOn(tester,
            'Simulateur - Connaître les risques naturels auxquels votre logement est exposé');
        await iScrollDownTo(tester, 'Choisissez une adresse');
        await iEnterInTheAutocompleteField(tester, "110 Rue Garibaldi");
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData', 'responseData'],
              [
                'GET',
                '/utilisateurs/%7BuserId%7D/risques_adresse?latitude=45.766368&longitude=4.850666',
                200,
                null,
                [
                  {
                    "type_risque": "secheresse",
                    "niveau_risque": "faible",
                    "titre": "Risques de sécheresse"
                  },
                  {
                    "type_risque": "seisme",
                    "niveau_risque": "faible",
                    "titre": "Risques sismiques"
                  },
                  {
                    "type_risque": "inondation",
                    "niveau_risque": "moyen",
                    "titre": "Risques d'inondations"
                  },
                  {
                    "type_risque": "radon",
                    "niveau_risque": "faible",
                    "titre": "Risques d'exposition au radon"
                  },
                  {
                    "type_risque": "submersion",
                    "niveau_risque": "tres_faible",
                    "titre": "Risques de submersion"
                  },
                  {
                    "type_risque": "tempete",
                    "niveau_risque": "tres_faible",
                    "titre": "Risques de tempêtes"
                  },
                  {
                    "type_risque": "argile",
                    "niveau_risque": "faible",
                    "titre": "Risques retrait-gonflement des sols argileux"
                  }
                ]
              ],
              [
                'GET',
                '/utilisateurs/%7BuserId%7D/risques_commune?code_commune=69386',
                200,
                null,
                {
                  "code_commune": "69386",
                  "nom_commune": "Lyon 6e Arrondissement",
                  "nombre_catastrophes_naturels": 20,
                  "pourcentage_commune_risque_inondation": 35,
                  "pourcentage_commune_risque_secheresse_geotechnique": 21
                }
              ],
              ['PATCH', '/utilisateurs/{userId}/logement', 200, null, {}]
            ]));
        await iTapOn(tester, '110 Rue Garibaldi 69006 Lyon');
        await iTapOn(tester, 'Choisir');
        await iDontSee(tester, 'Choisir');
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'POST',
                "/utilisateurs/{userId}/actions/simulateur/action_simulateur_maif/faite",
                200,
                null
              ],
              [
                'PATCH',
                "/utilisateurs/{userId}/logement",
                200,
                {
                  "rue": "Rue Garibaldi",
                  "numero_rue": "110",
                  "code_postal": "69006",
                  "code_commune": "69386",
                  "latitude": 45.766368,
                  "longitude": 4.850666
                }
              ]
            ]));
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Modifier l'adresse comme adresse principale''',
          success,
        );
      }
    });
  });
}
