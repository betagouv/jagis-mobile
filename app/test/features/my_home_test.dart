// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_tap_on.dart';
import './step/the_api_will_return.dart';
import './step/i_see.dart';
import './step/i_scroll_down_to.dart';
import './step/the_api_receive.dart';
import './step/i_enter_in_the_autocomplete_field.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''My home''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
      await iTapOnTheMenuButton(tester);
      await iTapOn(tester, 'Mon profil');
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Voir la page avec les informations minimales''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Voir la page avec les informations minimales''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/logement',
                200,
                {
                  "code_postal": "38280",
                  "commune": "VILLETTE D ANTHON",
                  "commune_label": "VILLETTE D ANTHON",
                  "code_commune": "38557",
                  "est_prm_present": false,
                  "est_prm_obsolete": false,
                  "est_adresse_complete": false
                }
              ],
              [
                'GET',
                '/communes_v2?code_postal=38280',
                200,
                [
                  {"code": "38011", "label": "ANTHON"},
                  {"code": "38197", "label": "JANNEYRIAS"},
                  {"code": "38557", "label": "VILLETTE D ANTHON"}
                ]
              ]
            ]));
        await iTapOn(tester, 'Mon logement');
        await iSee(tester, '38280');
        await iSee(tester, "VILLETTE D ANTHON");
      } catch (_) {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir la page avec les informations minimales''',
          success,
        );
      }
    });
    testWidgets('''Mettre à jour''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Mettre à jour''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/logement',
                200,
                {
                  "code_postal": "38280",
                  "commune": "Villette-d'Anthon",
                  "commune_label": "Villette-d'Anthon",
                  "code_commune": "38557",
                  "est_prm_present": false,
                  "est_prm_obsolete": false,
                  "est_adresse_complete": false
                }
              ],
              [
                'GET',
                '/communes_v2?code_postal=38280',
                200,
                [
                  {"code": "38011", "label": "ANTHON"},
                  {"code": "38197", "label": "JANNEYRIAS"},
                  {"code": "38557", "label": "VILLETTE D ANTHON"}
                ]
              ],
              ['PATCH', '/utilisateurs/{userId}/logement', 200, {}]
            ]));
        await iTapOn(tester, 'Mon logement');
        await iScrollDownTo(tester, 'Un appartement');
        await iTapOn(tester, 'Un appartement');
        await iTapOn(tester, 'Mettre à jour mes informations');
        await theApiReceive(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'PATCH',
                '/utilisateurs/{userId}/logement',
                200,
                {
                  "code_postal": "38280",
                  "code_commune": "38557",
                  "type": "appartement"
                }
              ]
            ]));
      } catch (_) {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Mettre à jour''',
          success,
        );
      }
    });
    testWidgets('''Supprimer mon adresse''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Supprimer mon adresse''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/logement',
                200,
                {
                  "code_postal": "38280",
                  "commune": "Villette-d'Anthon",
                  "rue": "Rue des Cyprès",
                  "numero_rue": "36",
                  "longitude": 5.115947,
                  "latitude": 45.793095,
                  "commune_label": "Villette-d'Anthon",
                  "code_commune": "38557",
                  "est_prm_present": false,
                  "est_prm_obsolete": false,
                  "est_adresse_complete": true
                }
              ],
              [
                'GET',
                '/communes_v2?code_postal=38280',
                200,
                [
                  {"code": "38011", "label": "ANTHON"},
                  {"code": "38197", "label": "JANNEYRIAS"},
                  {"code": "38557", "label": "VILLETTE D ANTHON"}
                ]
              ],
              ['PATCH', '/utilisateurs/{userId}/logement', 200, {}]
            ]));
        await iTapOn(tester, 'Mon logement');
        await iSee(tester, "36 Rue des Cyprès 38280 Villette-d'Anthon");
        await iTapOn(tester, 'Supprimer mon adresse');
        await theApiReceive(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'PATCH',
                '/utilisateurs/{userId}/logement',
                200,
                {
                  "latitude": null,
                  "longitude": null,
                  "numero_rue": null,
                  "rue": null
                }
              ]
            ]));
      } catch (_) {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Supprimer mon adresse''',
          success,
        );
      }
    });
    testWidgets('''Mettre l'adresse complète''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Mettre l'adresse complète''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/logement',
                200,
                {
                  "code_postal": "38280",
                  "commune": "Villette-d'Anthon",
                  "rue": "Rue des Cyprès",
                  "numero_rue": "36",
                  "longitude": 5.115947,
                  "latitude": 45.793095,
                  "commune_label": "Villette-d'Anthon",
                  "code_commune": "38557",
                  "est_prm_present": false,
                  "est_prm_obsolete": false,
                  "est_adresse_complete": true
                }
              ],
              [
                'GET',
                '/communes_v2?code_postal=38280',
                200,
                [
                  {"code": "38011", "label": "ANTHON"},
                  {"code": "38197", "label": "JANNEYRIAS"},
                  {"code": "38557", "label": "VILLETTE D ANTHON"}
                ]
              ],
              ['PATCH', '/utilisateurs/{userId}/logement', 200, {}]
            ]));
        await iTapOn(tester, 'Mon logement');
        await iEnterInTheAutocompleteField(tester, "110 Rue Garibaldi");
        await iTapOn(tester, '110 Rue Garibaldi 69006 Lyon');
        await iTapOn(tester, 'Mettre à jour mes informations');
        await theApiReceive(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                'PATCH',
                '/utilisateurs/{userId}/logement',
                200,
                {
                  "latitude": 45.766368,
                  "longitude": 4.850666,
                  "numero_rue": "110",
                  "rue": "Rue Garibaldi",
                  "code_postal": "69006",
                  "code_commune": "69386"
                }
              ]
            ]));
      } catch (_) {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Mettre l'adresse complète''',
          success,
        );
      }
    });
  });
}
