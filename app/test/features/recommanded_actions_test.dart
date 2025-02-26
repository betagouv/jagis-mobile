// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/initialize_context.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on.dart';
import './step/i_see.dart';

void main() {
  group('''Mes actions recommandées''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await initializeContext(tester);
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
      await iTapOn(tester, '🍛 Me nourrir');
    }

    testWidgets(
        '''La première fois que j'arrive sur la page Me nourrir alors la popup s'affiche''',
        (tester) async {
      await bddSetUp(tester);
      await iSee(tester, "Envie d’avoir un vrai impact ?");
    });
  });
}
