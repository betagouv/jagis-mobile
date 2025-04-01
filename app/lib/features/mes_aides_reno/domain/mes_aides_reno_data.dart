import 'package:equatable/equatable.dart';

class MesAidesRenoData extends Equatable {
  const MesAidesRenoData({required this.iframeUrl});

  final String iframeUrl;

  @override
  List<Object?> get props => [iframeUrl];
}
