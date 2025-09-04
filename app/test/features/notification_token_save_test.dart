// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/the_notification_token_save_endpoint_has_been_called.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Save notification token''', () {
    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets(
        '''Login to my account is successful and notification token is saved''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Login to my account is successful and notification token is saved''');
        await iAmLoggedIn(tester);
        await theApplicationIsLaunched(tester);
        await theNotificationTokenSaveEndpointHasBeenCalled(tester);
      } catch (_) {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Login to my account is successful and notification token is saved''',
          success,
        );
      }
    });
  });
}
