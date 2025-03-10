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

  group('''Par où souhaitez-vous commencer ?''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''See proposals by theme''', (tester) async {
      var success = true;
      try {
        await beforeEach('''See proposals by theme''');
        await bddSetUp(tester);
        await iSee(tester,
            'D’après nos calculs, à Dole, voici ce que nous pouvons vous proposer :');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''See proposals by theme''',
          success,
        );
      }
    });
  });
}
