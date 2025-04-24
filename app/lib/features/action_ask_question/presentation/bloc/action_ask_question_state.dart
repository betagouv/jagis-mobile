import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class ActionAskQuestionState extends Equatable {
  const ActionAskQuestionState({required this.message, required this.isSend});

  final String message;
  final bool isSend;

  ActionAskQuestionState copyWith({final String? message, final bool? isSend}) =>
      ActionAskQuestionState(message: message ?? this.message, isSend: isSend ?? this.isSend);

  @override
  List<Object> get props => [message, isSend];
}
