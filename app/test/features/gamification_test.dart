// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_see_points.dart';
import './step/the_api_will_return.dart';
import './step/i_see.dart';
import './step/i_tap_on.dart';
import './step/the_api_receives.dart';
import './step/i_dont_see.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Gamification''', () {
    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Voir le points au lancement de l'application''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Voir le points au lancement de l'application''');
        await iAmLoggedIn(tester);
        await theApplicationIsLaunched(tester);
        await iSeePoints(tester, '650');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir le points au lancement de l'application''',
          success,
        );
      }
    });
    testWidgets('''Voir le popup de reset si c'est un ancien compte''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Voir le popup de reset si c'est un ancien compte''');
        await iAmLoggedIn(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                'GET',
                '/utilisateurs/{userId}',
                200,
                {
                  "pseudo": "Lucas",
                  "is_onboarding_done": true,
                  "popup_reset_est_vue": false
                }
              ],
              [
                "POST",
                "/utilisateurs/{userId}/gamification/popup_reset_vue",
                200,
                {}
              ]
            ]));
        await theApplicationIsLaunched(tester);
        await iSee(tester, 'Il y a du nouveau sur J’agis !');
        await iTapOn(tester, 'Continuer');
        await iSee(tester, 'Merci pour votre soutien !');
        await iTapOn(tester, 'Récolter');
        await theApiReceives(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'requestData'],
              [
                "POST",
                "/utilisateurs/{userId}/gamification/popup_reset_vue",
                200,
                null
              ]
            ]));
        await iDontSee(tester, 'Merci pour votre soutien !');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir le popup de reset si c'est un ancien compte''',
          success,
        );
      }
    });
  });
}
