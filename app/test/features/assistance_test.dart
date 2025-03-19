// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_scroll_down.dart';
import './step/i_see.dart';
import './step/i_dont_see.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_tap_on.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Assistance''', () {
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

    testWidgets('''Show 2 first assistances on the home page''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Show 2 first assistances on the home page''');
        await bddSetUp(tester);
        await iScrollDown(tester);
        await iScrollDown(tester);
        await iSee(tester, 'Rénover son logement');
        await iSee(tester, 'Acheter un vélo');
        await iDontSee(tester, 'Composter ses déchets');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Show 2 first assistances on the home page''',
          success,
        );
      }
    });
    testWidgets('''Show assistances on the assistance page''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Show assistances on the assistance page''');
        await bddSetUp(tester);
        await iTapOnTheMenuButton(tester);
        await iTapOn(tester, 'Aides');
        await iSee(tester, 'Simulateur');
        await iSee(tester, 'Rénover son logement');
        await iSee(tester, 'Acheter un vélo');
        await iSee(tester, 'Composter ses déchets');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Show assistances on the assistance page''',
          success,
        );
      }
    });
    testWidgets('''Filter assistances by theme''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Filter assistances by theme''');
        await bddSetUp(tester);
        await iTapOnTheMenuButton(tester);
        await iTapOn(tester, 'Aides');
        await iTapOn(tester, 'Me déplacer');
        await iSee(tester, 'Acheter un vélo');
        await iDontSee(tester, 'Rénover son logement');
        await iDontSee(tester, 'Composter ses déchets');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Filter assistances by theme''',
          success,
        );
      }
    });
    testWidgets('''Go on the assistance detail page''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Go on the assistance detail page''');
        await bddSetUp(tester);
        await iTapOnTheMenuButton(tester);
        await iTapOn(tester, 'Aides');
        await iTapOn(tester, 'Composter ses déchets');
        await iSee(tester, 'Composter ses déchets');
        await iDontSee(tester, 'Acheter un vélo');
        await iDontSee(tester, 'Rénover son logement');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Go on the assistance detail page''',
          success,
        );
      }
    });
  });
}
