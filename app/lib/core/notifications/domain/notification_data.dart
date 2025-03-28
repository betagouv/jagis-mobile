import 'package:app/features/actions/domain/action_type.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class NotificationData extends Equatable {
  const NotificationData(this.pageId);

  final String pageId;

  @override
  List<Object> get props => [pageId];
}

@immutable
final class QuizNotificationData extends NotificationData {
  const QuizNotificationData(super.pageId);
}

@immutable
final class ArticleNotificationData extends NotificationData {
  const ArticleNotificationData(super.pageId);
}

@immutable
final class ActionNotificationData extends NotificationData {
  const ActionNotificationData(super.pageId, this.actionType);

  final ActionType actionType;

  @override
  List<Object> get props => [...super.props, actionType];
}
