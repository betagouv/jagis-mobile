import 'package:app/features/actions/infrastructure/actions_repository.dart';
import 'package:app/features/actions/presentation/bloc/actions_event.dart';
import 'package:app/features/actions/presentation/bloc/actions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionsBloc extends Bloc<ActionsEvent, ActionsState> {
  ActionsBloc({required final ActionsRepository repository}) : super(const ActionsInitial()) {
    on<ActionsLoadRequested>((final event, final emit) async {
      emit(const ActionsLoadInProgress());
      final result = await repository.fetch();

      emit(
        result.fold(
          (final l) => ActionsLoadFailure(errorMessage: l.toString()),
          (final r) => ActionsLoadSuccess(actions: r.actions, themeFilters: r.themes, titleFilter: '', alreadyConsulted: false),
        ),
      );
    });

    on<ActionsFilterByTitleRequested>((final event, final emit) async {
      switch (state) {
        case ActionsInitial():
        case ActionsLoadInProgress():
        case ActionsLoadFailure():
          break;
        case ActionsLoadSuccess():
          final currentThemes =
              (state as ActionsLoadSuccess).themeFilters.where((final e) => e.selected).map((final e) => e.code).toList();
          final result = await repository.fetch(themes: currentThemes, title: event.value);

          emit(
            result.fold(
              (final l) => ActionsLoadFailure(errorMessage: l.toString()),
              (final r) => ActionsLoadSuccess(
                actions: r.actions,
                themeFilters: r.themes,
                titleFilter: event.value,
                alreadyConsulted: r.alreadyConsulted,
              ),
            ),
          );
      }
    });

    on<ActionsFilterByThemeRequested>((final event, final emit) async {
      switch (state) {
        case ActionsInitial():
        case ActionsLoadInProgress():
        case ActionsLoadFailure():
          break;
        case final ActionsLoadSuccess currentState:
          final currentTitle = currentState.titleFilter;
          final newThemes = currentState.themeFilters.where((final e) => e.selected).map((final e) => e.code).toList();
          if (newThemes.contains(event.theme)) {
            newThemes.remove(event.theme);
          } else {
            newThemes.add(event.theme);
          }
          final result = await repository.fetch(themes: newThemes, title: currentTitle);

          emit(
            result.fold(
              (final l) => ActionsLoadFailure(errorMessage: l.toString()),
              (final r) => ActionsLoadSuccess(
                actions: r.actions,
                themeFilters: r.themes,
                titleFilter: currentTitle,
                alreadyConsulted: r.alreadyConsulted,
              ),
            ),
          );
      }
    });

    on<ActionsFilterByConsultedRequested>((final event, final emit) async {
      switch (state) {
        case ActionsInitial() || ActionsLoadInProgress() || ActionsLoadFailure():
          break;
        case final ActionsLoadSuccess currentState:
          final currentThemes = currentState.themeFilters.where((final e) => e.selected).map((final e) => e.code).toList();
          final result = await repository.fetch(
            themes: currentThemes,
            title: currentState.titleFilter,
            alreadyConsulted: event.value,
          );

          emit(
            result.fold(
              (final l) => ActionsLoadFailure(errorMessage: l.toString()),
              (final r) => ActionsLoadSuccess(
                actions: r.actions,
                themeFilters: r.themes,
                titleFilter: currentState.titleFilter,
                alreadyConsulted: r.alreadyConsulted,
              ),
            ),
          );
      }
    });
  }
}
