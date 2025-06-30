import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I go back
Future<void> iGoBack(final WidgetTester tester) async {
  await TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.handlePlatformMessage(
    'flutter/navigation',
    const JSONMessageCodec().encodeMessage(<String, dynamic>{'method': 'popRoute'}),
    (final data) {},
  );
  await tester.pumpAndSettle();
}
