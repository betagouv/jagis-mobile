// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/bdd_hooks/hooks.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_have_articles_in_my_library.dart';
import './step/i_tap_on.dart';
import './step/i_see.dart';
import './step/i_enter_in_the_search_by_title_field.dart';
import './step/i_dont_see.dart';
import './step/i_filter_with_theme.dart';
import './step/i_filter_by_favorites.dart';
import './step/i_tap_on_the_first_article.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Article library''', () {
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

    testWidgets('''See 1 article''', (tester) async {
      var success = true;
      try {
        await beforeEach('''See 1 article''');
        await bddSetUp(tester);
        await iHaveArticlesInMyLibrary(tester, 1);
        await iTapOn(tester, 'Bibliothèque');
        await iSee(tester, '1 article');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''See 1 article''',
          success,
        );
      }
    });
    testWidgets('''See articles''', (tester) async {
      var success = true;
      try {
        await beforeEach('''See articles''');
        await bddSetUp(tester);
        await iHaveArticlesInMyLibrary(tester, 2);
        await iTapOn(tester, 'Bibliothèque');
        await iSee(tester, '2 articles');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''See articles''',
          success,
        );
      }
    });
    testWidgets('''See 0 article''', (tester) async {
      var success = true;
      try {
        await beforeEach('''See 0 article''');
        await bddSetUp(tester);
        await iHaveArticlesInMyLibrary(tester, 0);
        await iTapOn(tester, 'Bibliothèque');
        await iSee(tester, '0 article');
        await iSee(tester, 'Aucun article trouvé');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''See 0 article''',
          success,
        );
      }
    });
    testWidgets('''Filter articles by title''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Filter articles by title''');
        await bddSetUp(tester);
        await iHaveArticlesInMyLibrary(tester, 2);
        await iTapOn(tester, 'Bibliothèque');
        await iEnterInTheSearchByTitleField(tester, 'vêtements');
        await iSee(tester, '1 article');
        await iSee(tester, "Comment réduire l'impact de ses vêtements ?");
        await iDontSee(tester, "Qu'est-ce qu'une alimentation durable ?");
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Filter articles by title''',
          success,
        );
      }
    });
    testWidgets('''Filter articles by theme''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Filter articles by theme''');
        await bddSetUp(tester);
        await iHaveArticlesInMyLibrary(tester, 2);
        await iTapOn(tester, 'Bibliothèque');
        await iFilterWithTheme(tester, '🥦 Alimentation');
        await iSee(tester, '1 article');
        await iSee(tester, "Qu'est-ce qu'une alimentation durable ?");
        await iDontSee(tester, "Comment réduire l'impact de ses vêtements ?");
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Filter articles by theme''',
          success,
        );
      }
    });
    testWidgets('''Filter articles by favorites''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Filter articles by favorites''');
        await bddSetUp(tester);
        await iHaveArticlesInMyLibrary(tester, 2);
        await iTapOn(tester, 'Bibliothèque');
        await iFilterByFavorites(tester);
        await iSee(tester, '1 article');
        await iSee(tester, "Qu'est-ce qu'une alimentation durable ?");
        await iDontSee(tester, "Comment réduire l'impact de ses vêtements ?");
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Filter articles by favorites''',
          success,
        );
      }
    });
    testWidgets('''Go to an article''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Go to an article''');
        await bddSetUp(tester);
        await iHaveArticlesInMyLibrary(tester, 2);
        await iTapOn(tester, 'Bibliothèque');
        await iTapOnTheFirstArticle(tester);
        await iSee(tester, "Qu'est-ce qu'une alimentation durable ?");
        await iSee(tester,
            "Comment réduire l'impact de notre alimentation sur le climat ?");
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Go to an article''',
          success,
        );
      }
    });
  });
}
