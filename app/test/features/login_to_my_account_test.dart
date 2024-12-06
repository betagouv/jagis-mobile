// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/initialize_context.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on.dart';
import './step/i_see.dart';
import './step/i_enter_in_the_field.dart';
import './step/i_tap_on_login_button.dart';
import './step/i_enter_in_the_pin_field.dart';

void main() {
  group('''Login to my account''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await initializeContext(tester);
      await theApplicationIsLaunched(tester);
      await iTapOn(tester, "J’ai déjà un compte");
    }

    testWidgets('''Login to my account is successful''', (tester) async {
      await bddSetUp(tester);
      await iSee(tester, 'Accédez à mon compte J’agis');
      await iEnterInTheField(tester, 'joe@doe.fr', 'Mon adresse email');
      await iEnterInTheField(tester, 'Azertyuiop1&', 'Mot de passe');
      await iTapOnLoginButton(tester);
      await iSee(tester, 'Entrez le code reçu par e-mail !');
      await iEnterInThePinField(tester, '999999');
      await iSee(tester, 'Bienvenue sur J’agis ! Faisons connaissance...');
    });
  });
}
