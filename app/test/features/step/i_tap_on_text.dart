import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/finders.dart';

/// Usage: I tap on {1} text {'Découvrir'}
Future<void> iTapOnText(final WidgetTester tester, final int number, final String text) async {
  final descendant = find.descendant(of: find.byType(GestureDetector), matching: findText(text));
  await tester.tap(descendant.at(number));
  await tester.pump();
  await tester.pump(Durations.medium3);
  await tester.pump();
  await tester.pump();
}
