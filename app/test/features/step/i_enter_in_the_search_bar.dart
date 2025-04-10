import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iEnterInTheSearchBar(final WidgetTester tester, final String text, final String label) async {
  final field = find.byWidgetPredicate((final widget) => widget is DsfrSearchBar && widget.hintText == label).first;
  await tester.enterText(field, text);
  await tester.testTextInput.receiveAction(TextInputAction.search);
  await tester.pumpAndSettle();
}
