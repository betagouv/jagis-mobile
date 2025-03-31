// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on.dart';
import './step/i_see.dart';
import './step/i_dont_see.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Seasonal fruits and vegetables service''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
      await iTapOn(tester, '🍛 Me nourrir');
      await iTapOn(tester, '1 calendrier de fruits et légumes de saison');
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''See seasonal fruits and vegetables''', (tester) async {
      var success = true;
      try {
        await beforeEach('''See seasonal fruits and vegetables''');
        await bddSetUp(tester);
        await iSee(tester, 'Les fruits et légumes pour le mois de');
        await iSee(tester, 'janvier');
        await iSee(tester, 'Poire');
        await iDontSee(tester, 'Fraise');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''See seasonal fruits and vegetables''',
          success,
        );
      }
    });
    testWidgets(
        '''Change the month to view different seasonal fruits and vegetables''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Change the month to view different seasonal fruits and vegetables''');
        await bddSetUp(tester);
        await iTapOn(tester, 'janvier');
        await iTapOn(tester, 'juin');
        await iSee(tester, 'Fraise');
        await iDontSee(tester, 'Poire');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Change the month to view different seasonal fruits and vegetables''',
          success,
        );
      }
    });
  });
}
