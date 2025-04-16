// ignore_for_file: avoid-unassigned-stream-subscriptions

import 'dart:async';

import 'package:app/core/notifications/domain/notification_data.dart';
import 'package:app/core/notifications/infrastructure/firebase_options.dart';
import 'package:app/core/notifications/infrastructure/notification_data_mapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  static const _topicAll = 'all';
  final _messageController = StreamController<NotificationData>.broadcast();

  Future<void> initializeApp() => Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Future<String?> getToken() => _executePlatformSafeCallback(() async => FirebaseMessaging.instance.getToken());

  Future<AuthorizationStatus> requestPermission() async {
    final permission = await FirebaseMessaging.instance.requestPermission();
    if (permission.authorizationStatus == AuthorizationStatus.authorized) {
      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
      await _executePlatformSafeCallback(() async => FirebaseMessaging.instance.subscribeToTopic(_topicAll));
    }

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null && initialMessage.data.isNotEmpty) {
      _messageController.add(NotificationDataMapper.fromJson(initialMessage.data));
    }

    FirebaseMessaging.onMessageOpenedApp.listen((final event) {
      if (event.data.isEmpty) {
        return;
      }

      _messageController.add(NotificationDataMapper.fromJson(event.data));
    });

    return permission.authorizationStatus;
  }

  /// Solution pour éviter le crash sur iOS 15.x
  ///
  /// [iOS 15.x and APNS token has not been set yet.](https://github.com/firebase/flutterfire/issues/17188)
  Future<T?> _executePlatformSafeCallback<T>(final AsyncValueGetter<T?> asyncOperation) async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        return asyncOperation();
      }

      return null;
    }

    return asyncOperation();
  }

  Stream<NotificationData> get onMessageOpenedApp => _messageController.stream;

  Future<void> deleteToken() async {
    await _executePlatformSafeCallback(() async => FirebaseMessaging.instance.unsubscribeFromTopic(_topicAll));
    await _executePlatformSafeCallback(() async => FirebaseMessaging.instance.deleteToken());
  }
}
