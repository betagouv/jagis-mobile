import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/finders.dart';

/// Usage: I scroll down to {'Rénover son logement'}
Future<void> iScrollDownTo(final WidgetTester tester, final String text) async {
  await tester.scrollUntilVisible(
    findText(text, skipOffstage: false).first,
    300,
    scrollable:
        find.byWidgetPredicate((final widget) => widget is Scrollable && widget.axisDirection == AxisDirection.down).first,
  );
  await tester.pump();
  await tester.pump(Durations.medium3);
}
