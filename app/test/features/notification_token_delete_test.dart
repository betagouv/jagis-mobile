// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_tap_on.dart';
import './step/the_notification_token_delete_endpoint_has_been_called.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Delete notification token''', () {
    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets(
        '''L'utilisateur se déconnecte de l'application alors le token de notification est supprimé''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''L'utilisateur se déconnecte de l'application alors le token de notification est supprimé''');
        await iAmLoggedIn(tester);
        await theApplicationIsLaunched(tester);
        await iTapOnTheMenuButton(tester);
        await iTapOn(tester, 'Se déconnecter');
        await theNotificationTokenDeleteEndpointHasBeenCalled(tester);
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''L'utilisateur se déconnecte de l'application alors le token de notification est supprimé''',
          success,
        );
      }
    });
  });
}
