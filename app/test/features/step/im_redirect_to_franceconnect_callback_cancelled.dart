import 'package:app/app/router/app_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

/// Usage: I'm redirect to FranceConnect callback cancelled
Future<void> imRedirectToFranceconnectCallbackCancelled(final WidgetTester tester) async {
  GoRouter.of(navigatorKey.currentContext!).go('https://www.jagis.gouv.fr/fc-login-callback');
  await tester.pumpAndSettle();
}
