// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on.dart';
import './step/i_see.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Mes actions recommandées''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
      await iTapOn(tester, '🍛 Me nourrir');
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets(
        '''La première fois que j'arrive sur la page Me nourrir alors la popup s'affiche''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''La première fois que j'arrive sur la page Me nourrir alors la popup s'affiche''');
        await bddSetUp(tester);
        await iSee(tester, "Envie d’avoir un vrai impact ?");
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''La première fois que j'arrive sur la page Me nourrir alors la popup s'affiche''',
          success,
        );
      }
    });
  });
}
