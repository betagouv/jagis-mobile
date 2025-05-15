import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum MesAidesRenoStateStatus { initial, loading, failure, success }

@immutable
final class MesAidesRenoState extends Equatable {
  const MesAidesRenoState({required this.status, this.errorMessage, this.iframeUrl, this.whenIsDone});
  const MesAidesRenoState.init() : this(status: MesAidesRenoStateStatus.initial);
  const MesAidesRenoState.loading() : this(status: MesAidesRenoStateStatus.loading);
  const MesAidesRenoState.failure(final String errorMessage)
    : this(status: MesAidesRenoStateStatus.failure, errorMessage: errorMessage);
  const MesAidesRenoState.success(final String iframeUrl, {final bool skipQuestions = false})
    : this(status: MesAidesRenoStateStatus.success, iframeUrl: iframeUrl, whenIsDone: skipQuestions);

  final MesAidesRenoStateStatus status;
  final String? errorMessage;
  final String? iframeUrl;
  final bool? whenIsDone;

  @override
  List<Object?> get props => [status, errorMessage, iframeUrl, whenIsDone];
}
