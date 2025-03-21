import 'package:app/features/quiz/domain/quiz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class MesAidesRenoState extends Equatable {
  const MesAidesRenoState();

  @override
  List<Object> get props => [];
}

@immutable
final class MesAidesRenoInit extends MesAidesRenoState {
  const MesAidesRenoInit();
}

@immutable
final class MesAidesRenoActionDone extends MesAidesRenoState {
  const MesAidesRenoActionDone();
}
