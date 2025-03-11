import 'package:app/features/aids/item/presentation/bloc/aid_event.dart';
import 'package:app/features/aids/item/presentation/bloc/aid_state.dart';
import 'package:app/features/aids/list/infrastructure/aids_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AidBloc extends Bloc<AidEvent, AidState> {
  AidBloc({required final AidsRepository repository}) : super(const AidStateLoading()) {
    on<AidSelected>((final event, final emit) => emit(AidStateSuccess(event.value)));

    on<AidSelectedById>((final event, final emit) async {
      final aidResult = await repository.fetchById(event.aidId);

      aidResult.fold((final exception) => emit(AidStateErrorLoading(exception)), (final aid) => emit(AidStateSuccess(aid)));
    });
  }
}
