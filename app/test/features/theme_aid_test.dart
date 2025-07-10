// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/the_api_will_return.dart';
import './step/i_tap_on_text.dart';
import './step/i_scroll_down_to.dart';
import './step/i_see.dart';
import './step/i_dont_see.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Aides dans les thématiques''', () {
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

    testWidgets('''Voir les aides''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Voir les aides''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/thematiques/logement',
                200,
                {
                  "thematique": "logement",
                  "est_personnalisation_necessaire": true,
                  "enchainement_questions_personnalisation":
                      "ENCHAINEMENT_KYC_personnalisation_logement",
                  "liste_actions_recommandees": [],
                  "nombre_actions": 27,
                  "nombre_aides": 6,
                  "nombre_simulateurs": 0,
                  "nom_commune": "Villette-d'Anthon",
                  "est_utilisateur_ngc": false
                }
              ],
              [
                'GET',
                '/utilisateurs/%7BuserId%7D/aides_v2?thematique=logement',
                200,
                {
                  "couverture_aides_ok": false,
                  "liste_aides": [
                    {
                      "content_id": "9",
                      "titre":
                          "Être accompagné par France Rénov pour votre rénovation énergétique",
                      "contenu": "<h1>Contenu</h1>",
                      "derniere_maj": "2025-06-16T00:00:00.000Z",
                      "url_simulateur": null,
                      "url_source":
                          "https://france-renov.gouv.fr/preparer-projet/trouver-conseiller",
                      "url_demande":
                          "https://france-renov.gouv.fr/preparer-projet/trouver-conseiller",
                      "is_simulateur": false,
                      "codes_postaux": [],
                      "thematiques": ["logement"],
                      "thematiques_label": ["🏡 Logement"],
                      "montant_max": null,
                      "besoin_desc": "Rénover son logement",
                      "besoin": "reno_logement",
                      "clicked_demande": false,
                      "clicked_infos": false,
                      "partenaire_nom": "Gouvernement Français",
                      "partenaire_url": null,
                      "partenaire_logo_url":
                          "https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1739369270/logo_vectoriel_republique_francaise_afb2d8ca57.jpg",
                      "echelle": "National",
                      "est_gratuit": true,
                      "deja_vue_le": "2025-07-07T14:59:17.175Z"
                    }
                  ]
                }
              ],
              [
                'GET',
                '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/ENCHAINEMENT_KYC_personnalisation_logement/first',
                200,
                {
                  "nombre_total_questions": 5,
                  "nombre_total_questions_effectives": 5,
                  "position_courante": 1,
                  "question_courante": {
                    "code": "KYC_type_logement",
                    "question": "Dans quel type de logement vivez-vous ?",
                    "reponse_multiple": [
                      {
                        "code": "type_maison",
                        "label": "Maison",
                        "selected": false
                      },
                      {
                        "code": "type_appartement",
                        "label": "Appartement",
                        "selected": false
                      }
                    ],
                    "is_answered": false,
                    "is_skipped": false,
                    "categorie": "recommandation",
                    "points": 5,
                    "type": "choix_unique",
                    "is_NGC": true,
                    "thematique": "logement"
                  },
                  "is_first": true,
                  "is_last": false,
                  "is_out_of_range": false
                }
              ]
            ]));
        await iTapOnText(tester, 1, '🏠 Me loger');
        await iScrollDownTo(tester, 'Mes aides');
        await iSee(tester, 'Mes aides');
        await iSee(tester,
            'Être accompagné par France Rénov pour votre rénovation énergétique');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir les aides''',
          success,
        );
      }
    });
    testWidgets('''Ne pas voir la section Aides si aucune aide''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Ne pas voir la section Aides si aucune aide''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/thematiques/logement',
                200,
                {
                  "thematique": "logement",
                  "est_personnalisation_necessaire": true,
                  "enchainement_questions_personnalisation":
                      "ENCHAINEMENT_KYC_personnalisation_logement",
                  "liste_actions_recommandees": [],
                  "nombre_actions": 27,
                  "nombre_aides": 6,
                  "nombre_simulateurs": 0,
                  "nom_commune": "Villette-d'Anthon",
                  "est_utilisateur_ngc": false
                }
              ],
              [
                'GET',
                '/utilisateurs/%7BuserId%7D/aides_v2?thematique=logement',
                200,
                {"couverture_aides_ok": false, "liste_aides": []}
              ],
              [
                'GET',
                '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/ENCHAINEMENT_KYC_personnalisation_logement/first',
                200,
                {
                  "nombre_total_questions": 5,
                  "nombre_total_questions_effectives": 5,
                  "position_courante": 1,
                  "question_courante": {
                    "code": "KYC_type_logement",
                    "question": "Dans quel type de logement vivez-vous ?",
                    "reponse_multiple": [
                      {
                        "code": "type_maison",
                        "label": "Maison",
                        "selected": false
                      },
                      {
                        "code": "type_appartement",
                        "label": "Appartement",
                        "selected": false
                      }
                    ],
                    "is_answered": false,
                    "is_skipped": false,
                    "categorie": "recommandation",
                    "points": 5,
                    "type": "choix_unique",
                    "is_NGC": true,
                    "thematique": "logement"
                  },
                  "is_first": true,
                  "is_last": false,
                  "is_out_of_range": false
                }
              ]
            ]));
        await iTapOnText(tester, 1, '🏠 Me loger');
        await iDontSee(tester, 'Mes aides');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Ne pas voir la section Aides si aucune aide''',
          success,
        );
      }
    });
  });
}
