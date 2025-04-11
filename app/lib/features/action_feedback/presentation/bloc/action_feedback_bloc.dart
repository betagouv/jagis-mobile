import 'package:app/features/action/infrastructure/action_repository.dart';
import 'package:app/features/action_feedback/presentation/bloc/action_feedback_event.dart';
import 'package:app/features/action_feedback/presentation/bloc/action_feedback_state.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionFeedbackBloc extends Bloc<ActionFeedbackEvent, ActionFeedbackState> {
  ActionFeedbackBloc(
    final ActionRepository repository, {
    required final ActionType type,
    required final String id,
    required final int rate,
  }) : super(ActionFeedbackState(rate: rate, message: '', isSend: false)) {
    on<ActionFeedbackRateChanged>((final event, final emit) => emit(state.copyWith(rate: event.rate)));
    on<ActionFeedbackMessageChanged>((final event, final emit) => emit(state.copyWith(message: event.message)));
    on<ActionFeedbackSendRequested>((final event, final emit) async {
      await repository.feedback(type: type, id: id, rate: state.rate, message: state.message);
      emit(state.copyWith(isSend: true));
    });
  }
}
