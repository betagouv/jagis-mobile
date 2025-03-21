import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class MesAidesRenoEvent extends Equatable {
  const MesAidesRenoEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class MesAidesRenoMarkAsDone extends MesAidesRenoEvent {
  const MesAidesRenoMarkAsDone();
}
