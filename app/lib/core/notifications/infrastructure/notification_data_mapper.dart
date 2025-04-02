import 'package:app/core/notifications/domain/notification_data.dart';
import 'package:app/features/actions/domain/action_type.dart';

abstract final class NotificationDataMapper {
  const NotificationDataMapper._();

  static NotificationData fromJson(final Map<String, dynamic> json) {
    final pageId = json['page_id'] as String;

    return switch (json['page_type'] as String) {
      'article' => ArticleNotificationData(pageId),
      'action' => ActionNotificationData(pageId, actionTypeFromAPIString(json['action_type'] as String)),
      _ => throw UnimplementedError(),
    };
  }
}
