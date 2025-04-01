// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/the_application_is_launched.dart';

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
