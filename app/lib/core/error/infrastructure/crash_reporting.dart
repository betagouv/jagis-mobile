// ignore_for_file: avoid-mutating-parameters

import 'package:sentry_flutter/sentry_flutter.dart';

abstract final class CrashReporting {
  static Future<void> init() => SentryFlutter.init((final p0) {
    p0.considerInAppFramesByDefault = false;
  });

  static Future<void> captureException(final dynamic exception, {final dynamic stackTrace}) async {
    await Sentry.captureException(exception, stackTrace: stackTrace);
  }

  static Future<void> dispose() async {
    await Sentry.close();
  }
}
