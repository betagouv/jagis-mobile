import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class ActionFeedbackState extends Equatable {
  const ActionFeedbackState({required this.rate, required this.message, required this.isSend});

  final int rate;
  final String message;
  final bool isSend;

  ActionFeedbackState copyWith({final int? rate, final String? message, final bool? isSend}) =>
      ActionFeedbackState(rate: rate ?? this.rate, message: message ?? this.message, isSend: isSend ?? this.isSend);

  @override
  List<Object> get props => [rate, message, isSend];
}
