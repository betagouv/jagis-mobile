import 'dart:async';

import 'package:app/features/services/winter/infrastructure/winter_repository.dart';
import 'package:app/features/services/winter/presentation/pages/bloc/winter_actions_event.dart';
import 'package:app/features/services/winter/presentation/pages/bloc/winter_actions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WinterActionsBloc extends Bloc<WinterActionsEvent, WinterActionsState> {
  WinterActionsBloc(this._repository) : super(const WinterActionsState(actions: [])) {
    on<WinterActionsLoadRequested>(_onLoadRequested);
  }

  final WinterRepository _repository;

  Future<void> _onLoadRequested(final WinterActionsLoadRequested event, final Emitter<WinterActionsState> emit) async {
    try {
      final actions = await _repository.getActions();
      emit(WinterActionsState(actions: actions));
    } on Exception {
      emit(const WinterActionsState(actions: []));
    }
  }
}
