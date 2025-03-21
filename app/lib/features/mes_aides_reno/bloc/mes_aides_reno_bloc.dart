import 'package:app/features/mes_aides_reno/bloc/mes_aides_reno_event.dart';
import 'package:app/features/mes_aides_reno/bloc/mes_aides_reno_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesAidesRenoBloc extends Bloc<MesAidesRenoEvent, MesAidesRenoState> {
  MesAidesRenoBloc() : super(const MesAidesRenoInit()) {
    on<MesAidesRenoMarkAsDone>((final event, final emit) {
      emit(const MesAidesRenoActionDone());
    });
  }
}
