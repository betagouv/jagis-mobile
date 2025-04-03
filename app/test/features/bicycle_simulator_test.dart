// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_tap_on.dart';
import './step/i_see.dart';
import './step/i_scroll_down.dart';
import './step/i_enter_in_the_field.dart';
import './step/i_tap_on_dropdown_menu.dart';
import './step/i_dont_see.dart';
import './step/the_profile_endpoint_has_been_called.dart';
import './step/the_logement_endpoint_has_been_called.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Assistance''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
      await iTapOnTheMenuButton(tester);
      await iTapOn(tester, 'Aides');
      await iTapOn(tester, 'Acheter un vélo');
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Show bicycle simulator''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Show bicycle simulator''');
        await bddSetUp(tester);
        await iSee(tester, 'Simulateur');
        await iTapOn(tester, 'Accéder au simulateur');
        await iSee(tester, 'Simuler mon aide');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Show bicycle simulator''',
          success,
        );
      }
    });
    testWidgets('''Show default price''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Show default price''');
        await bddSetUp(tester);
        await iTapOn(tester, 'Accéder au simulateur');
        await iSee(tester, '1000');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Show default price''',
          success,
        );
      }
    });
    testWidgets('''Change price''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Change price''');
        await bddSetUp(tester);
        await iTapOn(tester, 'Accéder au simulateur');
        await iScrollDown(tester);
        await iTapOn(tester, 'Vélo pliant standard : 500 €');
        await iSee(tester, '500');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Change price''',
          success,
        );
      }
    });
    testWidgets('''Enter postal code''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Enter postal code''');
        await bddSetUp(tester);
        await iTapOn(tester, 'Accéder au simulateur');
        await iScrollDown(tester);
        await iEnterInTheField(tester, '39100', 'Code postal');
        await iTapOnDropdownMenu(tester);
        await iSee(tester, 'DOLE');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Enter postal code''',
          success,
        );
      }
    });
    testWidgets('''When amount is 0 then button is disabled''', (tester) async {
      var success = true;
      try {
        await beforeEach('''When amount is 0 then button is disabled''');
        await bddSetUp(tester);
        await iTapOn(tester, 'Accéder au simulateur');
        await iEnterInTheField(tester, '0', 'Prix du vélo');
        await iTapOn(tester, 'Estimer mes aides');
        await iDontSee(tester, 'Mes aides disponibles');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''When amount is 0 then button is disabled''',
          success,
        );
      }
    });
    testWidgets('''When the form is completed then button is enabled''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''When the form is completed then button is enabled''');
        await bddSetUp(tester);
        await iTapOn(tester, 'Accéder au simulateur');
        await iTapOn(tester, 'Vélo pliant standard : 500 €');
        await iScrollDown(tester);
        await iEnterInTheField(tester, '39100', 'Code postal');
        await iTapOnDropdownMenu(tester);
        await iTapOn(tester, 'DOLE');
        await iEnterInTheField(
            tester, '2.5', 'Nombre de parts fiscales de votre foyer');
        await iEnterInTheField(
            tester, '16000', 'Revenu fiscal de référence de mon foyer');
        await iTapOn(tester, 'Estimer mes aides');
        await theProfileEndpointHasBeenCalled(tester);
        await theLogementEndpointHasBeenCalled(tester);
        await iSee(tester, 'Mes aides disponibles');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''When the form is completed then button is enabled''',
          success,
        );
      }
    });
  });
}
