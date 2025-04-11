import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I tap on {'4 étoiles sur 4'} semantics
Future<void> iTapOnSemantics(final WidgetTester tester, final String text) async {
  await tester.tap(find.descendant(of: find.byType(InkWell), matching: find.bySemanticsLabel(text)));
  await tester.pump();
  await tester.pump(Durations.medium3);
  await tester.pump();
  await tester.pump();
}
