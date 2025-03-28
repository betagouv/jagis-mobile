import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I see {'1'} badges
Future<void> iSeeBadges(final WidgetTester tester, final String value) async {
  expect(find.bySemanticsLabel(Localisation.nombreBadges(int.parse(value))), findsOneWidget);
}
