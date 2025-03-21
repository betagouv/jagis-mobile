import 'package:app/features/environmental_performance/action/infrastructure/action_performance_repository.dart';
import 'package:app/features/environmental_performance/action/presentation/bloc/action_performance_finished_event.dart';
import 'package:app/features/environmental_performance/action/presentation/bloc/action_performance_finished_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionPerformanceFinishedBloc extends Bloc<ActionPerformanceFinishedEvent, ActionPerformanceFinishedState> {
  ActionPerformanceFinishedBloc(final ActionPerformanceRepository repository) : super(const ActionPerformanceFinishedInitial()) {
    on<ActionPerformanceFinishedLoadRequested>((final event, final emit) async {
      emit(const ActionPerformanceFinishedLoadInProgress());
      final result = await repository.fetch(event.type);
      result.fold(
        (final l) => emit(ActionPerformanceFinishedLoadFailure(l.toString())),
        (final r) => emit(ActionPerformanceFinishedLoadSuccess(r)),
      );
    });
  }
}
