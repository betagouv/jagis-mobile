// ignore_for_file: avoid-long-functions

import 'dart:async';

import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/core/infrastructure/timed_delay.dart';
import 'package:app/features/aids/list/infrastructure/aids_repository.dart';
import 'package:app/features/recommandations/infrastructure/recommandations_repository.dart';
import 'package:app/features/theme/core/infrastructure/theme_repository.dart';
import 'package:app/features/theme/presentation/bloc/theme_event.dart';
import 'package:app/features/theme/presentation/bloc/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(this._themeRepository, this._aidsRepository, this._recommandationsRepository, this._messageBus, this._timedDelay)
    : super(const ThemeInitial()) {
    on<ThemeFetchRequested>(_onFetch);
    on<ThemeRefreshRequested>(_onRefresh);
    on<ThemeResetRequested>(_onReset);
    on<ThemeRecommendationsRefreshRequested>(_onRecommendationsRefresh);
  }

  final ThemeRepository _themeRepository;
  final AidsRepository _aidsRepository;
  final RecommandationsRepository _recommandationsRepository;
  final MessageBus _messageBus;
  final TimedDelay _timedDelay;

  Future<void> _onFetch(final ThemeFetchRequested event, final Emitter<ThemeState> emit) async {
    emit(const ThemeLoadInProgress());
    final themeType = event.themeType;
    final themeDataResult = await _themeRepository.fetchTheme(themeType: themeType);
    final aidsResult = await _aidsRepository.fetchByTheme(themeType: themeType);
    final recommandationResult = await _recommandationsRepository.fetchByTheme(themeType: themeType);
    themeDataResult.fold((final error) => emit(ThemeLoadFailure(errorMessage: error.toString())), (final theme) {
      aidsResult.fold((final error) => emit(ThemeLoadFailure(errorMessage: error.toString())), (final aids) {
        recommandationResult.fold((final error) => emit(ThemeLoadFailure(errorMessage: error.toString())), (
          final recommendations,
        ) {
          emit(ThemeLoadSuccess(themeInfo: theme, aids: aids, recommendations: recommendations));
        });
      });
    });
  }

  Future<void> _onRefresh(final ThemeRefreshRequested event, final Emitter<ThemeState> emit) async {
    final blocState = state;
    if (blocState is ThemeLoadSuccess) {
      final themeType = blocState.themeInfo.themeType;
      await _themeRepository.confirmCustomization(themeType: themeType);
      _messageBus.publish(startFirstTimeQuestionsToPersonalizeActionsTopic);
      final themeDataResult = await _themeRepository.fetchTheme(themeType: themeType);

      await _timedDelay.simulateDelay();

      themeDataResult.fold(
        (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
        (final themeInfo) => emit(blocState.copyWith(themeInfo: themeInfo)),
      );
    }
  }

  Future<void> _onReset(final ThemeResetRequested event, final Emitter<ThemeState> emit) async {
    final blocState = state;
    if (blocState is ThemeLoadSuccess) {
      final themeType = blocState.themeInfo.themeType;
      await _themeRepository.resetCustomization(themeType: themeType);
      final themeDataResult = await _themeRepository.fetchTheme(themeType: themeType);
      themeDataResult.fold(
        (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
        (final themeInfo) => emit(blocState.copyWith(themeInfo: themeInfo)),
      );
    }
  }

  Future<void> _onRecommendationsRefresh(final ThemeRecommendationsRefreshRequested event, final Emitter<ThemeState> emit) async {
    final blocState = state;
    if (blocState is ThemeLoadSuccess) {
      final themeType = blocState.themeInfo.themeType;
      final result = await _recommandationsRepository.fetchByTheme(themeType: themeType);
      result.fold(
        (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
        (final recommendations) => emit(blocState.copyWith(recommendations: recommendations)),
      );
    }
  }
}
