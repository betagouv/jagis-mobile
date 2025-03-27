// ignore_for_file: avoid-long-functions

import 'package:app/core/infrastructure/timed_delay.dart';
import 'package:app/features/theme/core/domain/theme_summary.dart';
import 'package:app/features/theme/core/infrastructure/theme_repository.dart';
import 'package:app/features/theme/presentation/bloc/theme_event.dart';
import 'package:app/features/theme/presentation/bloc/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required final ThemeRepository themeRepository, required final TimedDelay timedDelay})
    : _themeRepository = themeRepository,
      _timedDelay = timedDelay,
      super(const ThemeInitial()) {
    on<ThemeFetchRequested>(_onFetch);
    on<ThemeRefreshRequested>(_onRefresh);
    on<ThemeResetRequested>(_onReset);
    on<ThemeReplaceActionRequested>(_onReplaceAction);
  }

  final ThemeRepository _themeRepository;
  final TimedDelay _timedDelay;

  Future<void> _onFetch(final ThemeFetchRequested event, final Emitter<ThemeState> emit) async {
    emit(const ThemeLoadInProgress());
    final themeType = event.themeType;
    final themeDataResult = await _themeRepository.fetchTheme(themeType: themeType);
    final servicesResult = await _themeRepository.getServices(themeType);
    themeDataResult.fold(
      (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
      (final theme) => servicesResult.fold(
        (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
        (final services) => emit(
          ThemeLoadSuccess(
            theme: theme,
            summary: ThemeSummary(
              commune: theme.communeName,
              links: ThemeSummary.buildThemeLinksFor(
                themeType: theme.themeType,
                commune: theme.communeName,
                aidCount: theme.aidCount,
                recipeCount: theme.recipeCount,
              ),
            ),
            services: services,
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh(final ThemeRefreshRequested event, final Emitter<ThemeState> emit) async {
    final blocState = state;
    if (blocState is ThemeLoadSuccess) {
      final themeType = blocState.theme.themeType;
      await _themeRepository.confirmCustomization(themeType: themeType);
      final themeDataResult = await _themeRepository.fetchTheme(themeType: themeType);

      await _timedDelay.simulateDelay();

      themeDataResult.fold(
        (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
        (final theme) => emit(blocState.copyWith(theme: theme)),
      );
    }
  }

  Future<void> _onReset(final ThemeResetRequested event, final Emitter<ThemeState> emit) async {
    final blocState = state;
    if (blocState is ThemeLoadSuccess) {
      final themeType = blocState.theme.themeType;
      await _themeRepository.resetCustomization(themeType: themeType);
      final themeDataResult = await _themeRepository.fetchTheme(themeType: themeType);
      themeDataResult.fold(
        (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
        (final theme) => emit(
          blocState.copyWith(
            theme: theme,
            summary: ThemeSummary(
              commune: theme.communeName,
              links: ThemeSummary.buildThemeLinksFor(
                themeType: theme.themeType,
                commune: theme.communeName,
                aidCount: theme.aidCount,
                recipeCount: theme.recipeCount,
              ),
            ),
          ),
        ),
      );
    }
  }

  Future<void> _onReplaceAction(final ThemeReplaceActionRequested event, final Emitter<ThemeState> emit) async {
    final blocState = state;
    if (blocState is ThemeLoadSuccess) {
      final themeType = blocState.theme.themeType;
      await _themeRepository.replaceAction(themeType: themeType, actionSummary: event.action);
      final themeDataResult = await _themeRepository.fetchTheme(themeType: themeType);
      themeDataResult.fold(
        (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
        (final theme) => emit(
          blocState.copyWith(
            theme: theme,
            summary: ThemeSummary(
              commune: theme.communeName,
              links: ThemeSummary.buildThemeLinksFor(
                themeType: theme.themeType,
                commune: theme.communeName,
                aidCount: theme.aidCount,
                recipeCount: theme.recipeCount,
              ),
            ),
          ),
        ),
      );
    }
  }
}
