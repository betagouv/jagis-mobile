import 'package:app/features/mes_aides_reno/bloc/mes_aides_reno_event.dart';
import 'package:app/features/mes_aides_reno/bloc/mes_aides_reno_state.dart';
import 'package:app/features/mes_aides_reno/infrastructure/mes_aides_reno_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesAidesRenoBloc extends Bloc<MesAidesRenoEvent, MesAidesRenoState> {
  MesAidesRenoBloc(final MesAidesRenoRepository repository) : super(const MesAidesRenoState.init()) {
    on<MesAidesRenoIframeUrlRequested>((final event, final emit) async {
      emit(const MesAidesRenoState.loading());

      final result = await repository.getUrls();

      result.match((final l) => emit(const MesAidesRenoState.failure('Une erreur est survenue.')), (final r) {
        emit(
          MesAidesRenoState.success(
            event.skipQuestions ? r.iframeUrlWhenIsDone : r.iframeUrl,
            skipQuestions: event.skipQuestions,
          ),
        );
      });
    });

    on<MesAidesRenoSendSituation>((final event, final emit) async {
      final result = await repository.sendSituation(event.situation);

      result.match((final l) => emit(const MesAidesRenoState.failure('Une erreur est survenue.')), (final r) {});
    });
  }
}
