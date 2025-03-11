import 'package:flutter_test/flutter_test.dart';

/// Usage: I see {'Question 1 sur 3'} semantics
Future<void> iSeeSemantics(final WidgetTester tester, final String text) async {
  expect(find.bySemanticsLabel(text), findsOneWidget);
}
