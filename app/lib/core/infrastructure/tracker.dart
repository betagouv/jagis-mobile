import 'package:flutter/widgets.dart';
import 'package:matomo_tracker/matomo_tracker.dart';

class Tracker {
  const Tracker();

  Future<void> init({required final String siteId, required final String url}) async {
    await MatomoTracker.instance.initialize(siteId: siteId, url: url, verbosityLevel: Level.all);
  }

  void trackClick({required final String action, final String? name}) {
    if (!MatomoTracker.instance.initialized) {
      return;
    }
    MatomoTracker.instance.trackEvent(
      eventInfo: EventInfo(category: 'click', action: action, name: name),
    );
  }

  void trackNotificationOpened(final String name) {
    if (!MatomoTracker.instance.initialized) {
      return;
    }
    MatomoTracker.instance.trackEvent(
      eventInfo: EventInfo(category: 'notification', action: 'opened', name: name),
    );
  }

  void dispose() {
    MatomoTracker.instance.dispose();
  }

  NavigatorObserver get navigatorObserver =>
      MatomoTracker.instance.initialized ? MatomoGlobalObserver(tracker: MatomoTracker.instance) : NavigatorObserver();
}
