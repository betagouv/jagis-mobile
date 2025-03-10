import 'dart:async';

import 'package:app/features/theme/core/infrastructure/theme_repository.dart';
import 'package:app/features/theme/presentation/bloc/theme_event.dart';
import 'package:app/features/theme/presentation/bloc/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required final ThemeRepository themeRepository}) : super(const ThemeInitial()) {
    on<ThemeFetchRequested>((final event, final emit) async {
      emit(const ThemeLoadInProgress());
      final themeType = event.themeType;
      final themeDataResult = await themeRepository.fetchTheme(themeType: themeType);
      final missionsResult = await themeRepository.getMissions(themeType);
      final servicesResult = await themeRepository.getServices(themeType);
      themeDataResult.fold(
        (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
        (final theme) => missionsResult.fold(
          (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
          (final missions) => servicesResult.fold(
            (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
            (final services) => emit(ThemeLoadSuccess(theme: theme, missions: missions, services: services)),
          ),
        ),
      );
    });
    on<ThemeRefreshRequested>((final event, final emit) async {
      final blocState = state;
      if (blocState is ThemeLoadSuccess) {
        final themeType = blocState.theme.themeType;
        await themeRepository.confirmCustomization(themeType: themeType);
        final themeDataResult = await themeRepository.fetchTheme(themeType: themeType);

        await _waitingRoom();

        themeDataResult.fold(
          (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
          (final theme) => emit(blocState.copyWith(theme: theme)),
        );
      }
    });
    on<ThemeReplaceActionRequested>((final event, final emit) async {
      final blocState = state;
      if (blocState is ThemeLoadSuccess) {
        final themeType = blocState.theme.themeType;
        await themeRepository.replaceAction(themeType: themeType, actionSummary: event.action);
        final themeDataResult = await themeRepository.fetchTheme(themeType: themeType);
        themeDataResult.fold(
          (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
          (final theme) => emit(blocState.copyWith(theme: theme)),
        );
      }
    });
  }

  /// Fausse attente pour simuler la personnalisation
  Future<void> _waitingRoom() async {
    _refreshTimer?.cancel();
    final completer = Completer<void>();
    _refreshTimer = Timer(const Duration(seconds: 1), completer.complete);
    await completer.future;
  }

  Timer? _refreshTimer;

  @override
  Future<void> close() {
    _refreshTimer?.cancel();

    return super.close();
  }
}
