// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on.dart';
import './step/i_scroll_down.dart';
import './step/i_see.dart';
import './step/i_enter_in_the_field.dart';
import './step/i_enter_in_the_pin_field.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Forgot password''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theApplicationIsLaunched(tester);
      await iTapOn(tester, "J’ai déjà un compte");
      await iScrollDown(tester);
      await iTapOn(tester, 'Mot de passe oublié ?');
    }

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
        await iSee(tester, 'Mot de passe oublié - 1/2');
        await iEnterInTheField(tester, 'joe@doe.fr', 'Mon adresse email');
        await iTapOn(tester, 'Valider');
        await iSee(tester, 'Mot de passe oublié - 2/2');
        await iEnterInThePinField(tester, '999999');
        await iEnterInTheField(tester, 'Azertyuiop1&', 'Mot de passe');
        await iTapOn(tester, 'Valider');
        await iSee(tester, 'Accédez à mon compte J’agis');
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
  });
}
