// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on.dart';
import './step/the_email_dont_exists.dart';
import './step/i_see.dart';
import './step/i_enter_in_the_field.dart';
import './step/i_tap_on_create_my_account_button.dart';
import './step/im_redirect_to_magic_link_callback.dart';
import './step/the_email_already_exists.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Create a account''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theApplicationIsLaunched(tester);
      await iTapOn(tester, 'Je crée mon compte');
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Successful account creation''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Successful account creation''');
        await bddSetUp(tester);
        await theEmailDontExists(tester);
        await iSee(tester, 'Créer mon compte');
        await iEnterInTheField(tester, 'joe@doe.fr', 'Mon adresse email');
        await iTapOnCreateMyAccountButton(tester);
        await iSee(tester, 'Vérifiez votre boîte e-mail');
        await imRedirectToMagicLinkCallback(tester);
        await iSee(tester, 'Bienvenue sur J’agis ! Faisons connaissance…');
      } catch (_) {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Successful account creation''',
          success,
        );
      }
    });
    testWidgets('''See the error message when the email already exists''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''See the error message when the email already exists''');
        await bddSetUp(tester);
        await theEmailAlreadyExists(tester);
        await iEnterInTheField(tester, 'joe@doe.fr', 'Mon adresse email');
        await iTapOnCreateMyAccountButton(tester);
        await iSee(tester, 'Adresse électronique joe@doe.fr déjà existante');
      } catch (_) {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''See the error message when the email already exists''',
          success,
        );
      }
    });
  });
}
