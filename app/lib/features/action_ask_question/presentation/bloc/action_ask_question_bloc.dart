import 'package:app/features/action/infrastructure/action_repository.dart';
import 'package:app/features/action_ask_question/presentation/bloc/action_ask_question_event.dart';
import 'package:app/features/action_ask_question/presentation/bloc/action_ask_question_state.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionAskQuestionBloc extends Bloc<ActionAskQuestionEvent, ActionAskQuestionState> {
  ActionAskQuestionBloc(final ActionRepository repository, {required final ActionType type, required final String id})
    : super(const ActionAskQuestionState(message: '', isSend: false)) {
    on<ActionAskQuestionMessageChanged>((final event, final emit) => emit(state.copyWith(message: event.message)));
    on<ActionAskQuestionSendRequested>((final event, final emit) async {
      await repository.askQuestion(type: type, id: id, question: state.message);
      emit(state.copyWith(isSend: true));
    });
  }
}
