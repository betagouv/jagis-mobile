// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_have_actions_in_my_library.dart';
import './step/i_tap_on.dart';
import './step/i_see.dart';
import './step/i_dont_see.dart';
import './step/i_enter_in_the_search_by_title_field_actions.dart';
import './step/i_filter_with_action_theme.dart';
import './step/i_filter_by_action.dart';
import './step/i_have_action_detail_in_my_library.dart';
import './step/i_have_lvao_services_in_my_library.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Actions''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
      await iTapOnTheMenuButton(tester);
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''See all actions''', (tester) async {
      var success = true;
      try {
        await beforeEach('''See all actions''');
        await bddSetUp(tester);
        await iHaveActionsInMyLibrary(
            tester,
            const bdd.DataTable([
              ['type', 'code', 'title', 'nb_aids_available'],
              [
                'classique',
                '1',
                'Faire réparer une **paire de chaussures**',
                2
              ],
              [
                'classique',
                '2',
                'Contribuer à la **bonne santé de son sol**',
                0
              ],
              [
                'classique',
                '3',
                'Tester une **nouvelle recette végétarienne**',
                1
              ]
            ]));
        await iTapOn(tester, 'Actions');
        await iSee(tester, '🌧️ Contribuer à la bonne santé de son sol');
        await iSee(tester, '🌧️ Tester une nouvelle recette végétarienne');
        await iSee(tester, '🌧️ Faire réparer une paire de chaussures');
        await iDontSee(tester, '0 aide');
        await iSee(tester, '1 aide');
        await iSee(tester, '2 aides');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''See all actions''',
          success,
        );
      }
    });
    testWidgets('''Filter actions by title''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Filter actions by title''');
        await bddSetUp(tester);
        await iHaveActionsInMyLibrary(
            tester,
            const bdd.DataTable([
              ['type', 'code', 'title', 'nb_aids_available'],
              [
                'classique',
                '1',
                'Faire réparer une **paire de chaussures**',
                2
              ],
              [
                'classique',
                '2',
                'Contribuer à la **bonne santé de son sol**',
                0
              ],
              [
                'classique',
                '3',
                'Tester une **nouvelle recette végétarienne**',
                1
              ]
            ]));
        await iTapOn(tester, 'Actions');
        await iSee(tester, '🌧️ Tester une nouvelle recette végétarienne');
        await iSee(tester, '🌧️ Faire réparer une paire de chaussures');
        await iEnterInTheSearchByTitleFieldActions(tester, 'végétarienne');
        await iSee(tester, '🌧️ Tester une nouvelle recette végétarienne');
        await iDontSee(tester, 'Faire réparer une paire de chaussures');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Filter actions by title''',
          success,
        );
      }
    });
    testWidgets('''Filter actions by theme''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Filter actions by theme''');
        await bddSetUp(tester);
        await iHaveActionsInMyLibrary(
            tester,
            const bdd.DataTable([
              ['type', 'code', 'title', 'nb_aids_available'],
              [
                'classique',
                '1',
                'Faire réparer une **paire de chaussures**',
                2
              ],
              [
                'classique',
                '2',
                'Contribuer à la **bonne santé de son sol**',
                0
              ],
              [
                'classique',
                '3',
                'Tester une **nouvelle recette végétarienne**',
                1
              ]
            ]));
        await iTapOn(tester, 'Actions');
        await iSee(tester, '🌧️ Tester une nouvelle recette végétarienne');
        await iSee(tester, '🌧️ Faire réparer une paire de chaussures');
        await iFilterWithActionTheme(tester, '🥦 Alimentation');
        await iSee(tester, '🌧️ Tester une nouvelle recette végétarienne');
        await iDontSee(tester, 'Faire réparer une paire de chaussures');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Filter actions by theme''',
          success,
        );
      }
    });
    testWidgets('''Filter actions by already consulted''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Filter actions by already consulted''');
        await bddSetUp(tester);
        await iHaveActionsInMyLibrary(
            tester,
            const bdd.DataTable([
              ['type', 'code', 'title', 'nb_aids_available'],
              [
                'classique',
                '1',
                'Faire réparer une **paire de chaussures**',
                2
              ],
              [
                'classique',
                '2',
                'Contribuer à la **bonne santé de son sol**',
                0
              ],
              [
                'classique',
                '3',
                'Tester une **nouvelle recette végétarienne**',
                1
              ]
            ]));
        await iTapOn(tester, 'Actions');
        await iSee(tester, '🌧️ Tester une nouvelle recette végétarienne');
        await iSee(tester, '🌧️ Faire réparer une paire de chaussures');
        await iFilterByAction(tester, 'Déjà consultées');
        await iSee(tester, '🌧️ Tester une nouvelle recette végétarienne');
        await iDontSee(tester, 'Faire réparer une paire de chaussures');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Filter actions by already consulted''',
          success,
        );
      }
    });
    testWidgets('''Go to details action classic''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Go to details action classic''');
        await bddSetUp(tester);
        await iHaveActionsInMyLibrary(
            tester,
            const bdd.DataTable([
              ['type', 'code', 'title', 'nb_aids_available'],
              ['classique', '1', 'Faire réparer une **paire de chaussures**', 2]
            ]));
        await iHaveActionDetailInMyLibrary(
            tester,
            const bdd.DataTable([
              [
                'id',
                'title',
                'subTitle',
                'how',
                'why',
                'service_id',
                'service_category'
              ],
              [
                '1',
                'Faire réparer une **paire de chaussures**',
                'Faites des économies en donnant une seconde vie à vos paires de chaussures',
                '# Nos astuces\n\n- **Choisissez un cordonnier agréé** : pour profiter de l’aide d’État sur vos réparations\n\n- **Bottes, chaussures de ski, baskets** : toutes les chaussures sont éligibles\n\n- **Si vos chaussures sont trop abimées** : Déposez-les dans un point de collecte pour que valoriser les matériaux utilisés',
                '# En quelques mots\n\n- Pour chaque paire de chaussure réparée, vous économisez **entre 20 et 60€**\n\n- Les paires de chaussures jetées représentent plusieurs **milliers de tonnes** de déchets généralement non recyclables. \n\n- Chaque année, un Français achète en moyenne 4 paires de chaussures.',
                'longue_vie_objets',
                'reparer'
              ]
            ]));
        await iHaveLvaoServicesInMyLibrary(tester);
        await iTapOn(tester, 'Actions');
        await iTapOn(tester, '🌧️ Faire réparer une paire de chaussures');
        await iSee(tester,
            'Faites des économies en donnant une seconde vie à vos paires de chaussures');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Go to details action classic''',
          success,
        );
      }
    });
  });
}
