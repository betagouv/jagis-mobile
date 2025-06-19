// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_api_will_return.dart';
import './step/the_application_is_launched.dart';
import './step/i_see.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Ecological footprint''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets(
        '''Voir l'incitation à calculer son empreinte écologique lorsqu'il n'est pas terminé''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Voir l'incitation à calculer son empreinte écologique lorsqu'il n'est pas terminé''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/home_board',
                200,
                {
                  "nom_commune": "Lyon",
                  "total_national_actions_faites": 36,
                  "total_utilisateur_actions_faites": 3,
                  "pourcentage_bilan_done": 39,
                  "nombre_aides": 12,
                  "nombre_recettes": 1150,
                  "bilan_carbone_total_kg": 7569.006294661004,
                  "pourcentage_alimentation_reco_done": 100,
                  "pourcentage_consommation_reco_done": 100,
                  "pourcentage_logement_reco_done": 100,
                  "pourcentage_transport_reco_done": 33,
                  "pourcentage_global_reco_done": 86
                }
              ]
            ]));
        await theApplicationIsLaunched(tester);
        await iSee(tester, 'Calculer mon\nempreinte écologique');
        await iSee(tester, '39%');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir l'incitation à calculer son empreinte écologique lorsqu'il n'est pas terminé''',
          success,
        );
      }
    });
    testWidgets('''Voir son empreinte écologique lorsqu'il est pas terminé''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Voir son empreinte écologique lorsqu'il est pas terminé''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}/home_board',
                200,
                {
                  "nom_commune": "Lyon",
                  "total_national_actions_faites": 36,
                  "total_utilisateur_actions_faites": 3,
                  "pourcentage_bilan_done": 100,
                  "nombre_aides": 12,
                  "nombre_recettes": 1150,
                  "bilan_carbone_total_kg": 7569.006294661004,
                  "pourcentage_alimentation_reco_done": 100,
                  "pourcentage_consommation_reco_done": 100,
                  "pourcentage_logement_reco_done": 100,
                  "pourcentage_transport_reco_done": 33,
                  "pourcentage_global_reco_done": 86
                }
              ]
            ]));
        await theApplicationIsLaunched(tester);
        await iSee(tester, 'Mon empreinte\nécologique');
        await iSee(tester, '8t\nde CO2e/an');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir son empreinte écologique lorsqu'il est pas terminé''',
          success,
        );
      }
    });
  });
}
