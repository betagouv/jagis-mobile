import 'package:app/features/services/pdcn/infrastructure/pdcn_repository.dart';
import 'package:app/features/services/pdcn/presentation/pdcn_list/bloc/pdcn_event.dart';
import 'package:app/features/services/pdcn/presentation/pdcn_list/bloc/pdcn_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO(lsaudon): Factoriser les blocs pour les différents services
class PdcnBloc extends Bloc<PdcnEvent, PdcnState> {
  PdcnBloc(final PdcnRepository repository) : super(const PdcnInitial()) {
    on<PdcnLoadRequested>((final event, final emit) async {
      emit(const PdcnLoadInProgress());
      final result = await repository.fetch(category: event.category, limit: 4);
      result.fold((final l) => emit(PdcnLoadFailure(errorMessage: l.toString())), (final r) => emit(PdcnLoadSuccess(list: r)));
    });
  }
}
