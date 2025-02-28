// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on.dart';
import './step/im_redirect_to_franceconnect_callback.dart';
import './step/i_see.dart';
import './step/im_redirect_to_franceconnect_callback_cancelled.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''France Connect''', () {
    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Login with FranceConnect is successful''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Login with FranceConnect is successful''');
        await theApplicationIsLaunched(tester);
        await iTapOn(tester, "J’ai déjà un compte");
        await iTapOn(tester, "FranceConnect");
        await imRedirectToFranceconnectCallback(tester);
        await iSee(tester, 'Bienvenue sur J’agis ! Faisons connaissance...');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Login with FranceConnect is successful''',
          success,
        );
      }
    });
    testWidgets('''Login with FranceConnect is cancelled''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Login with FranceConnect is cancelled''');
        await theApplicationIsLaunched(tester);
        await iTapOn(tester, "J’ai déjà un compte");
        await iTapOn(tester, "FranceConnect");
        await imRedirectToFranceconnectCallbackCancelled(tester);
        await iSee(tester, 'J’ai déjà un compte');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Login with FranceConnect is cancelled''',
          success,
        );
      }
    });
  });
}
