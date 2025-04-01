import 'package:equatable/equatable.dart';

class MesAidesRenoEvent extends Equatable {
  const MesAidesRenoEvent();

  @override
  List<Object?> get props => [];
}

class MesAidesRenoIframeUrlRequested extends MesAidesRenoEvent {
  const MesAidesRenoIframeUrlRequested();
}

class MesAidesRenoSendSituation extends MesAidesRenoEvent {
  const MesAidesRenoSendSituation(this.situation);

  final Object situation;

  @override
  List<Object?> get props => [situation];
}
