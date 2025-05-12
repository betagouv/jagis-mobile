import 'package:flutter_test/flutter_test.dart';

import '../helper/finders.dart';
import '../helper/scroll_down_to.dart';

/// Usage: I scroll down to {'Rénover son logement'}
Future<void> iScrollDownTo(final WidgetTester tester, final String text) async {
  await scrollDownTo(tester, findText(text, skipOffstage: false).first);
}
