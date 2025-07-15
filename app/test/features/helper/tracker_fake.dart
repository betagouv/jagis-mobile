import 'package:app/core/infrastructure/tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TrackerFake extends Tracker {
  const TrackerFake();

  @override
  Future<void> init({required final String siteId, required final String url}) async {}

  @override
  void trackClick({required final String action, final String? name}) {}

  @override
  void trackNotificationOpened(final String name) {}

  @override
  void dispose() {}

  @override
  NavigatorObserver get navigatorObserver => _PrintObserver();
}

class _PrintObserver extends RouteObserver<PageRoute<dynamic>> {}
