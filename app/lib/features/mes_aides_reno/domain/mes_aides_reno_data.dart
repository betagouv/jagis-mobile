import 'package:equatable/equatable.dart';

class MesAidesRenoData extends Equatable {
  const MesAidesRenoData({required this.iframeUrl, required this.iframeUrlWhenIsDone});

  final String iframeUrl;

  /// URL allowing to skip answered questions and go directly to the
  /// eligibility results. To use when the action is done.
  final String iframeUrlWhenIsDone;

  @override
  List<Object?> get props => [iframeUrl, iframeUrlWhenIsDone];
}
