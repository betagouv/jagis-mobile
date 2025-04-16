import 'package:app/features/services/pres_de_chez_vous/infrastructure/action_pres_de_chez_vous_repository.dart';
import 'package:app/features/services/pres_de_chez_vous/presentation/bloc/pres_de_chez_vous_event.dart';
import 'package:app/features/services/pres_de_chez_vous/presentation/bloc/pres_de_chez_vous_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO(lsaudon): Factoriser les blocs pour les différents services
class PresDeChezVousBloc extends Bloc<PresDeChezVousEvent, PresDeChezVousState> {
  PresDeChezVousBloc(final ActionPresDeChezVousRepository repository) : super(const PresDeChezVousInitial()) {
    on<PresDeChezVousLoadRequested>((final event, final emit) async {
      emit(const PresDeChezVousLoadInProgress());
      final result = await repository.fetch(category: event.category);
      result.fold(
        (final l) => emit(PresDeChezVousLoadFailure(errorMessage: l.toString())),
        (final r) => emit(PresDeChezVousLoadSuccess(list: r)),
      );
    });
  }
}
