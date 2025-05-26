import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> scrollDownTo(final WidgetTester tester, final Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    300,
    scrollable: find
        .byWidgetPredicate((final widget) => widget is Scrollable && widget.axisDirection == AxisDirection.down)
        .first,
  );
  await tester.pump();
  await tester.pump(Durations.medium3);
}
