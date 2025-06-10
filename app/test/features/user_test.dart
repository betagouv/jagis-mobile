// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

    testWidgets('''On voit le pseudonyme sur la page d'accueil''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''On voit le pseudonyme sur la page d'accueil''');
        await iAmLoggedIn(tester);
        await theApplicationIsLaunched(tester);
        await iSee(tester, 'Bonjour,\nJoe !');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''On voit le pseudonyme sur la page d'accueil''',
          success,
        );
      }
    });
  });
}
