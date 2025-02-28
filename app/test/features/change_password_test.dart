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
import './step/i_enter_in_the_field.dart';
import './step/i_see_the_form_message.dart';
import './step/the_change_password_endpoint_has_been_called.dart';
import './step/the_change_password_endpoint_has_not_been_called.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Change password''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
      await iTapOnTheMenuButton(tester);
      await iTapOn(tester, 'Mon profil');
      await iScrollDownTo(tester, 'Options avancées');
      await iTapOn(tester, 'Options avancées');
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Change my password Successfully''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Change my password Successfully''');
        await bddSetUp(tester);
        await iEnterInTheField(tester, 'Azertyuiop1&', 'Mot de passe');
        await iSeeTheFormMessage(tester, '12 caractères minimum', 'valid');
        await iSeeTheFormMessage(
            tester, 'Au moins 1 majuscule et 1 minuscule', 'valid');
        await iSeeTheFormMessage(
            tester, '1 caractère spécial minimum', 'valid');
        await iSeeTheFormMessage(tester, '1 chiffre minimum', 'valid');
        await iTapOn(tester, 'Changer mon mot de passe');
        await theChangePasswordEndpointHasBeenCalled(tester);
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Change my password Successfully''',
          success,
        );
      }
    });
    testWidgets('''Change my password with an invalid password''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Change my password with an invalid password''');
        await bddSetUp(tester);
        await iEnterInTheField(tester, 'pasvalide', 'Mot de passe');
        await iSeeTheFormMessage(tester, '12 caractères minimum', 'info');
        await iSeeTheFormMessage(
            tester, 'Au moins 1 majuscule et 1 minuscule', 'info');
        await iSeeTheFormMessage(tester, '1 caractère spécial minimum', 'info');
        await iSeeTheFormMessage(tester, '1 chiffre minimum', 'info');
        await iTapOn(tester, 'Changer mon mot de passe');
        await theChangePasswordEndpointHasNotBeenCalled(tester);
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Change my password with an invalid password''',
          success,
        );
      }
    });
  });
}
