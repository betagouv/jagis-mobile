import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/infrastructure/action_repository.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/action/presentation/bloc/action_state.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionBloc extends Bloc<ActionEvent, ActionState> {
  ActionBloc({required final ActionRepository repository}) : super(const ActionState.initial()) {
    on<ActionLoadRequested>((final event, final emit) async {
      emit(const ActionState.inProgress());

      if (event.id == ActionSimulatorId.mesAidesReno.apiString) {
        emit(ActionState.success(action: mesAidesReno()));
      } else {
        final result = await repository.fetch(type: event.type, id: event.id);

        emit(
          result.fold((final l) => ActionState.failure(errorMessage: l.toString()), (final r) => ActionState.success(action: r)),
        );
      }
    });

    on<ActionMarkAsDone>((final event, final emit) async {
      if (event.id == ActionSimulatorId.mesAidesReno.apiString) {
        isDone = true;
        emit(ActionState.success(action: mesAidesReno()));

        return;
      }
      await repository.markAsDone(type: event.type, id: event.id);
      final result = await repository.fetch(type: event.type, id: event.id);
      emit(
        result.fold((final l) => ActionState.failure(errorMessage: l.toString()), (final r) => ActionState.success(action: r)),
      );
    });
  }

  static var isDone = false;

  static ActionSimulator mesAidesReno() => ActionSimulator(
    themeType: ThemeType.transport,
    id: ActionSimulatorId.mesAidesReno.apiString,
    title: 'Simulateur Mes Aides Reno',
    subTitle: '',
    alreadySeen: true,
    isDone: isDone,
    faq: const [],
    nbActionsDone: 10,
    aidSummaries: const [],
    score: 10,
    questions: const [],
    why: '## En quelques mots',
    rate: 0,
  );
}
