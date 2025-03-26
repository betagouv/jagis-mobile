import 'package:app/features/action/infrastructure/action_repository.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/action/presentation/bloc/action_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionBloc extends Bloc<ActionEvent, ActionState> {
  ActionBloc({required final ActionRepository repository}) : super(const ActionState.initial()) {
    on<ActionLoadRequested>((final event, final emit) async {
      emit(const ActionState.inProgress());
      final result = await repository.fetch(type: event.type, id: event.id);

      emit(
        result.fold((final l) => ActionState.failure(errorMessage: l.toString()), (final r) => ActionState.success(action: r)),
      );
    });

    on<ActionMarkAsDone>((final event, final emit) async {
      await repository.markAsDone(type: event.type, id: event.id);
      final result = await repository.fetch(type: event.type, id: event.id);
      emit(
        result.fold((final l) => ActionState.failure(errorMessage: l.toString()), (final r) => ActionState.success(action: r)),
      );
    });
  }
}
