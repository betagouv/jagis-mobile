import 'package:app/app/app.dart';
import 'package:app/app/router/deep_link.dart';
import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/authentication/infrastructure/authentication_storage.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:clock/clock.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';
import '../helper/notification_service_fake.dart';
import '../helper/timed_delay_fake.dart';
import '../helper/tracker_fake.dart';

/// Usage: The application is launched
Future<void> theApplicationIsLaunched(final WidgetTester tester) async {
  final authenticationStorage = AuthenticationStorage(FeatureContext.instance.secureStorage);
  await authenticationStorage.init();
  final clock = Clock.fixed(DateTime(1992, 9));
  final authenticationService = AuthenticationService(authenticationStorage: authenticationStorage, clock: clock);
  await authenticationService.checkAuthenticationStatus();
  final dioMock = FeatureContext.instance.dioMock;
  final dioHttpClient = DioHttpClient(dio: dioMock, authenticationService: authenticationService);
  const tracker = TrackerFake();
  final messageBus = MessageBus();

  await tester.pumpFrames(
    App(
      clock: clock,
      tracker: tracker,
      deepLink: DeepLink(),
      messageBus: messageBus,
      apiClient: dioHttpClient,
      addressClient: dioMock,
      packageInfo: FeatureContext.instance.packageInfo,
      notificationService: const NotificationServiceFake(AuthorizationStatus.authorized),
      authenticationService: authenticationService,
      timedDelay: const TimedDelayFake(),
    ),
    Durations.short1,
  );
  await tester.pumpAndSettle();
}
