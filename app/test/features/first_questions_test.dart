// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/the_application_is_launched.dart';
import './step/the_email_dont_exists.dart';
import './step/i_tap_on.dart';
import './step/i_enter_in_the_field.dart';
import './step/i_accept_the_terms_of_use.dart';
import './step/i_tap_on_create_my_account_button.dart';
import './step/i_enter_in_the_pin_field.dart';
import './step/i_scroll_down_to.dart';
import './step/i_select_date_in_the_field.dart';
import './step/i_see.dart';
import './step/i_select_in_the_field.dart';
import './step/i_see_the_home_page.dart';
import './step/the_api_will_return.dart';
import './step/i_see_semantics.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Onboarding''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theApplicationIsLaunched(tester);
      await theEmailDontExists(tester);
      await iTapOn(tester, 'Je crée mon compte');
      await iEnterInTheField(tester, 'joe@doe.fr', 'Mon adresse email');
      await iEnterInTheField(tester, 'Azertyuiop1&', 'Mot de passe');
      await iAcceptTheTermsOfUse(tester);
      await iTapOnCreateMyAccountButton(tester);
      await iEnterInThePinField(tester, '999999');
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Répondre aux premieres questions''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Répondre aux premieres questions''');
        await bddSetUp(tester);
        await iEnterInTheField(tester, 'Joe', 'Mon pseudonyme');
        await iScrollDownTo(tester, 'Ma date de naissance');
        await iSelectDateInTheField(
            tester, '15/01/1974', 'Ma date de naissance');
        await iTapOn(tester, 'Continuer');
        await iSee(tester,
            'Pour découvrir des aides, services et contenus disponibles proches de chez vous, indiquez-nous votre lieu de résidence.');
        await iEnterInTheField(tester, '39100', 'Code postal');
        await iSelectInTheField(tester, 'DOLE', 'Commune');
        await iTapOn(tester, 'Continuer');
        await iSee(tester, 'J’agis est encore en expérimentation !');
        await iTapOn(tester, 'J’ai compris');
        await iSee(tester, 'C’est presque terminé !');
        await iTapOn(tester, 'La cuisine et l’alimentation');
        await iTapOn(tester, 'Continuer');
        await iSee(tester, 'Tout est prêt !');
        await iTapOn(tester, 'C’est parti !');
        await iSeeTheHomePage(tester);
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Répondre aux premieres questions''',
          success,
        );
      }
    });
    testWidgets('''Saisir un pseudonyme invalide''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Saisir un pseudonyme invalide''');
        await bddSetUp(tester);
        await iEnterInTheField(tester, '123', 'Mon pseudonyme');
        await iSee(tester, 'Le pseudonyme n’est pas valide.');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Saisir un pseudonyme invalide''',
          success,
        );
      }
    });
    testWidgets(
        '''Saisir un pseudonyme valide et recevoir une erreur de l'API''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Saisir un pseudonyme valide et recevoir une erreur de l'API''');
        await bddSetUp(tester);
        await theApiWillReturn(
            tester,
            const bdd.DataTable([
              ['method', 'path', 'statusCode', 'responseData'],
              [
                "PATCH",
                "/utilisateurs/{userId}/profile",
                400,
                {"message": "Une erreur est survenue."}
              ]
            ]));
        await iEnterInTheField(tester, 'Lucas', 'Mon pseudonyme');
        await iScrollDownTo(tester, 'Ma date de naissance');
        await iSelectDateInTheField(
            tester, '15/01/1974', 'Ma date de naissance');
        await iTapOn(tester, 'Continuer');
        await iSee(tester, 'Une erreur est survenue.');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Saisir un pseudonyme valide et recevoir une erreur de l'API''',
          success,
        );
      }
    });
    testWidgets('''Vérifier l'accessibilité sur la page du pseudonyme''',
        (tester) async {
      var success = true;
      try {
        await beforeEach(
            '''Vérifier l'accessibilité sur la page du pseudonyme''');
        await bddSetUp(tester);
        await iSeeSemantics(tester, 'Question 1 sur 3');
        await iSeeSemantics(
            tester, 'Bienvenue sur J’agis ! Faisons connaissance…');
        await iSeeSemantics(tester,
            'Nous avons quelques questions à vous poser pour personnaliser votre expérience !');
        await iSeeSemantics(tester, 'Mon pseudonyme');
        await iSeeSemantics(tester, 'Continuer');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Vérifier l'accessibilité sur la page du pseudonyme''',
          success,
        );
      }
    });
  });
}
