import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ActionFeedbackEvent extends Equatable {
  const ActionFeedbackEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ActionFeedbackRateChanged extends ActionFeedbackEvent {
  const ActionFeedbackRateChanged(this.rate);

  final int rate;

  @override
  List<Object> get props => [rate];
}

@immutable
final class ActionFeedbackMessageChanged extends ActionFeedbackEvent {
  const ActionFeedbackMessageChanged(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

@immutable
final class ActionFeedbackSendRequested extends ActionFeedbackEvent {
  const ActionFeedbackSendRequested();

  @override
  List<Object> get props => [];
}
