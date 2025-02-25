// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/initialize_context.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_see.dart';

void main() {
  group('''Par où souhaitez-vous commencer ?''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await initializeContext(tester);
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
    }

    testWidgets('''See proposals by theme''', (tester) async {
      await bddSetUp(tester);
      await iSee(tester,
          'D’après nos calculs, à Dole, voici ce que nous pouvons vous proposer :');
    });
  });
}
