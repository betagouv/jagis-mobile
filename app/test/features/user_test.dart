// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_see.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''User''', () {
    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''I see my name on the home page''', (tester) async {
      var success = true;
      try {
        await beforeEach('''I see my name on the home page''');
        await iAmLoggedIn(tester);
        await theApplicationIsLaunched(tester);
        await iSee(tester, 'Bonjour,\nJoe !');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''I see my name on the home page''',
          success,
        );
      }
    });
  });
}
