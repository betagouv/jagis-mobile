import 'package:app/features/services/core/infrastructure/service_repository.dart';
import 'package:app/features/services/pdcn/domain/pdcn_detail.dart';
import 'package:app/features/services/pdcn/presentation/pdcn_detail/bloc/pdcn_detail_event.dart';
import 'package:app/features/services/pdcn/presentation/pdcn_detail/bloc/pdcn_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PdcnDetailBloc extends Bloc<PdcnDetailEvent, PdcnDetailState> {
  PdcnDetailBloc(final ServiceRepository repository) : super(const PdcnDetailInitial()) {
    on<PdcnDetailLoadRequested>((final event, final emit) async {
      emit(const PdcnDetailLoadInProgress());
      final result = await repository.fetchOne(service: 'proximite', id: event.id, fromJson: PdcnDetail.fromJson);
      result.fold((final error) => emit(const PdcnDetailLoadFailure()), (final detail) => emit(PdcnDetailLoadSuccess(detail)));
    });
  }
}
