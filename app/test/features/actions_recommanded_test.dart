// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_text.dart';
import './step/i_see.dart';
import './step/i_scroll_down_to.dart';
import './step/i_tap_on.dart';
import './step/i_have_theme_with_actions.dart';
import './step/i_have_theme_with_no_action.dart';
import './step/i_have_theme_with_customization_needed.dart';

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
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Voir les actions recommandées''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Voir les actions recommandées''');
        await bddSetUp(tester);
        await iTapOnText(tester, 1, '🚅 Me déplacer');
        await iSee(tester, 'Mes actions recommandées');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir les actions recommandées''',
          success,
        );
      }
    });
    testWidgets('''Voir la popup si la personnalisation n'a pas été faite''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Voir la popup si la personnalisation n'a pas été faite''');
        await bddSetUp(tester);
        await iTapOnText(tester, 1, '🚅 Me déplacer');
        await iSee(tester, 'Envie d’avoir un vrai impact ?');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Voir la popup si la personnalisation n'a pas été faite''',
          success,
        );
      }
    });
    testWidgets('''Commencer les questions''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Commencer les questions''');
        await bddSetUp(tester);
        await iTapOnText(tester, 1, '🚅 Me déplacer');
        await iScrollDownTo(tester, 'Commencer');
        await iTapOn(tester, 'Commencer');
        await iSee(tester,
            "Avez-vous pris l'avion au moins une fois ces 3 dernières années ?");
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Commencer les questions''',
          success,
        );
      }
    });
    testWidgets('''Répondre à toutes les questions''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Répondre à toutes les questions''');
        await bddSetUp(tester);
        await iTapOnText(tester, 1, '🚅 Me déplacer');
        await iScrollDownTo(tester, 'Commencer');
        await iTapOn(tester, 'Commencer');
        await iSee(tester,
            "Avez-vous pris l'avion au moins une fois ces 3 dernières années ?");
        await iTapOn(tester, "Oui");
        await iScrollDownTo(tester, 'Question suivante');
        await iTapOn(tester, "Question suivante");
        await iSee(tester, "Êtes-vous équipé(e) d’un vélo ?");
        await iTapOn(tester, "Non");
        await iHaveThemeWithActions(tester);
        await iTapOn(tester, "Question suivante");
        await iSee(
            tester, 'Trouver le type de voiture qui vous convient le mieux');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Répondre à toutes les questions''',
          success,
        );
      }
    });
    testWidgets('''Refaire le questionnaire''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Refaire le questionnaire''');
        await bddSetUp(tester);
        await iHaveThemeWithNoAction(tester);
        await iTapOnText(tester, 1, '🚅 Me déplacer');
        await iHaveThemeWithCustomizationNeeded(tester);
        await iScrollDownTo(tester, 'Refaire');
        await iTapOn(tester, 'Refaire');
        await iSee(tester, 'Envie d’avoir un vrai impact ?');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Refaire le questionnaire''',
          success,
        );
      }
    });
  });
}
