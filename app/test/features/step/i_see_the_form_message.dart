import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I see the {'12 caractères minimum'} form message {'valid'}
Future<void> iSeeTheFormMessage(final WidgetTester tester, final String text, final String typeString) async {
  final type =
      typeString == 'valid'
          ? DsfrComponentStateEnum.success
          : typeString == 'info'
          ? DsfrComponentStateEnum.info
          : UnimplementedError();
  expect(
    find.byWidgetPredicate(
      (final widget) =>
          widget is DsfrComponentStateWidget && widget.componentState.state == type && widget.componentState.text == text,
    ),
    findsOneWidget,
  );
}
