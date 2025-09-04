import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: Button {'Question suivante'} is disabled
Future<void> buttonIsDisabled(final WidgetTester tester, final String label) async {
  final button = find.byWidgetPredicate(
    (final widget) => widget is DsfrButton && widget.label == label && widget.onPressed == null,
  );
  expect(button, findsOneWidget);
}
