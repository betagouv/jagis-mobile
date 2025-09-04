// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/the_application_is_launched.dart';
import './step/i_see.dart';
import './step/i_am_logged_in.dart';
import './step/i_tap_on_the_menu_button.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Version''', () {
    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''User launches app and sees version number''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''User launches app and sees version number''');
        await theApplicationIsLaunched(tester);
        await iSee(tester, '1.2.3+4');
      } catch (_) {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''User launches app and sees version number''',
          success,
        );
      }
    });
    testWidgets('''User views version number through menu''', (tester) async {
      var success = true;
      try {
        await beforeEach('''User views version number through menu''');
        await iAmLoggedIn(tester);
        await theApplicationIsLaunched(tester);
        await iTapOnTheMenuButton(tester);
        await iSee(tester, '1.2.3+4');
      } catch (_) {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''User views version number through menu''',
          success,
        );
      }
    });
  });
}
