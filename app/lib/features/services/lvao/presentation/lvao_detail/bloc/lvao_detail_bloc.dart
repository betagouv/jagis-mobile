import 'package:app/features/services/core/infrastructure/service_repository.dart';
import 'package:app/features/services/lvao/domain/lvao_actor.dart';
import 'package:app/features/services/lvao/presentation/lvao_detail/bloc/lvao_detail_event.dart';
import 'package:app/features/services/lvao/presentation/lvao_detail/bloc/lvao_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LvaoDetailBloc extends Bloc<LvaoDetailEvent, LvaoDetailState> {
  LvaoDetailBloc(final ServiceRepository repository) : super(const LvaoDetailInitial()) {
    on<LvaoDetailLoadRequested>((final event, final emit) async {
      emit(const LvaoDetailLoadInProgress());
      final result = await repository.fetchOne(service: 'longue_vie_objets', id: event.id, fromJson: LvaoActor.fromJson);
      result.fold((final error) => emit(const LvaoDetailLoadFailure()), (final detail) => emit(LvaoDetailLoadSuccess(detail)));
    });
  }
}
