// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_tap_on.dart';
import './step/i_scroll_down_to.dart';
import './step/the_account_deletion_endpoint_has_been_called.dart';
import './step/i_see.dart';
import './step/the_account_deletion_endpoint_has_not_been_called.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Delete my account''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
      await iTapOnTheMenuButton(tester);
      await iTapOn(tester, 'Mon profil');
      await iScrollDownTo(tester, 'Options avancées');
      await iTapOn(tester, 'Options avancées');
      await iScrollDownTo(tester, 'Supprimer mon compte');
      await iTapOn(tester, 'Supprimer mon compte');
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Confirm account deletion''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Confirm account deletion''');
        await bddSetUp(tester);
        await iTapOn(tester, 'Confirmer');
        await theAccountDeletionEndpointHasBeenCalled(tester);
        await iSee(
            tester, 'Ensemble, améliorons nos habitudes au jour le jour');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Confirm account deletion''',
          success,
        );
      }
    });
    testWidgets('''Cancel account deletion''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Cancel account deletion''');
        await bddSetUp(tester);
        await iTapOn(tester, 'Annuler');
        await theAccountDeletionEndpointHasNotBeenCalled(tester);
        await iSee(tester, 'Options avancées');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Cancel account deletion''',
          success,
        );
      }
    });
  });
}
