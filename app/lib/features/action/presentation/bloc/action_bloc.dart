import 'package:app/features/action/infrastructure/action_repository.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/action/presentation/bloc/action_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionBloc extends Bloc<ActionEvent, ActionState> {
  ActionBloc({required final ActionRepository repository}) : super(const ActionInitial()) {
    on<ActionLoadRequested>((final event, final emit) async {
      emit(const ActionLoadInProgress());
      final result = await repository.fetch(type: event.type, id: event.id);

      emit(result.fold((final l) => ActionLoadFailure(errorMessage: l.toString()), (final r) => ActionLoadSuccess(action: r)));
    });

    on<ActionMarkAsDone>((final event, final emit) async {
      await repository.markAsDone(type: event.action.type, id: event.action.id);
      emit(ActionMarkedAsDone(event.action));
    });
  }
}
