import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/finders.dart';

/// Usage: I tap on {'Je crée mon compte'}
Future<void> iTapOn(final WidgetTester tester, final String text) async {
  await tester.tap(find.descendant(of: find.byType(GestureDetector), matching: findText(text)));
  await tester.pump();
  await tester.pump(Durations.medium3);
  await tester.pump();
}
