import 'package:equatable/equatable.dart';

class MesAidesRenoData extends Equatable {
  const MesAidesRenoData({required this.iframeUrl, required this.iframeUrlWhenDone});

  final String iframeUrl;

  /// URL allowing to skip answered questions and go directly to the
  /// eligibility results. To use when the action is done.
  final String iframeUrlWhenDone;

  @override
  List<Object?> get props => [iframeUrl, iframeUrlWhenDone];
}
