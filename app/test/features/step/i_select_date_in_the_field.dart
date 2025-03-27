import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'i_tap_on.dart';

/// Usage: I select {'15/01/1973'} date in the {'Ma date de naissance'} field
Future<void> iSelectDateInTheField(final WidgetTester tester, final String date, final String field) async {
  await iTapOn(tester, field);
  await tester.tap(find.byKey(ValueKey(DateFormat('dd/MM/yyyy', 'fr_FR').parse(date))));
  await iTapOn(tester, 'OK');
}
