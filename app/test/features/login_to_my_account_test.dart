// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on.dart';
import './step/i_see.dart';
import './step/i_enter_in_the_field.dart';
import './step/i_tap_on_login_button.dart';
import './step/i_enter_in_the_pin_field.dart';
import './step/i_am_logged_in.dart';
import './step/i_see_the_home_page.dart';
import './step/i_tap_on_the_menu_button.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Login to my account''', () {
    Future<void> bddSetUp(WidgetTester tester) async {}
    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Login to my account is successful''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Login to my account is successful''');
        await bddSetUp(tester);
        await theApplicationIsLaunched(tester);
        await iTapOn(tester, "J’ai déjà un compte");
        await iSee(tester, 'Accédez à mon compte J’agis');
        await iEnterInTheField(tester, 'joe@doe.fr', 'Mon adresse email');
        await iEnterInTheField(tester, 'Azertyuiop1&', 'Mot de passe');
        await iTapOnLoginButton(tester);
        await iSee(tester, 'Entrez le code reçu par e-mail !');
        await iEnterInThePinField(tester, '999999');
        await iSee(tester, 'Bienvenue sur J’agis ! Faisons connaissance…');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Login to my account is successful''',
          success,
        );
      }
    });
    testWidgets('''Already logged in''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Already logged in''');
        await bddSetUp(tester);
        await iAmLoggedIn(tester);
        await theApplicationIsLaunched(tester);
        await iSeeTheHomePage(tester);
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Already logged in''',
          success,
        );
      }
    });
    testWidgets('''Logout''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Logout''');
        await bddSetUp(tester);
        await iAmLoggedIn(tester);
        await theApplicationIsLaunched(tester);
        await iTapOnTheMenuButton(tester);
        await iTapOn(tester, 'Se déconnecter');
        await iSee(
            tester, 'Ensemble,\naméliorons\nnos habitudes\nau jour le jour');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Logout''',
          success,
        );
      }
    });
  });
}
