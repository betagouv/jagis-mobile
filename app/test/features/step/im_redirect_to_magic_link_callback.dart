import 'package:app/app/router/app_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

/// Usage: I'm redirect to magic link callback
Future<void> imRedirectToMagicLinkCallback(final WidgetTester tester) async {
  GoRouter.of(
    navigatorKey.currentContext!,
  ).go('https://www.jagis.gouv.fr/authentification/validation-lien-magique?email=lucas@dev.fr&code=999999');
  await tester.pumpAndSettle();
}
