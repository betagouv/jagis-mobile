import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I don't see {'0'} badges
Future<void> iDontSeeBadges(final WidgetTester tester, final String value) async {
  expect(find.bySemanticsLabel(Localisation.nombreBadges(int.parse(value))), findsNothing);
}
