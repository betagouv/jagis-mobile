import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class MesAidesRenoEvent extends Equatable {
  const MesAidesRenoEvent();

  @override
  List<Object?> get props => [];
}

@immutable
final class MesAidesRenoIframeUrlRequested extends MesAidesRenoEvent {
  const MesAidesRenoIframeUrlRequested();
}

@immutable
final class MesAidesRenoSendSituation extends MesAidesRenoEvent {
  const MesAidesRenoSendSituation(this.situation);

  final Map<String, dynamic> situation;

  @override
  List<Object> get props => [situation];
}
