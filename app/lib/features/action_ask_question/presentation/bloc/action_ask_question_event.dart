import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ActionAskQuestionEvent extends Equatable {
  const ActionAskQuestionEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ActionAskQuestionMessageChanged extends ActionAskQuestionEvent {
  const ActionAskQuestionMessageChanged(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

@immutable
final class ActionAskQuestionSendRequested extends ActionAskQuestionEvent {
  const ActionAskQuestionSendRequested();

  @override
  List<Object> get props => [];
}
