import 'dart:async';

import 'package:app/features/actions/infrastructure/actions_repository.dart';
import 'package:app/features/home/bloc/home_dashboard_event.dart';
import 'package:app/features/home/bloc/home_dashboard_state.dart';
import 'package:app/features/home/infrastructure/home_dashboard_repository.dart';
import 'package:app/features/recommandations/infrastructure/recommandations_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDashboardBloc extends Bloc<HomeDashboardEvent, HomeDashboardState> {
  HomeDashboardBloc(this._repository, this._recommandationsRepository, this._actionsRepository)
    : super(const HomeDashboardState.init()) {
    on<HomeDashboardLoadRequested>(_onLoadRequested);
    on<HomeDashboardActionsSwitchRequested>(_onActionsSwitchRequested);
    on<HomeDashboardRecommendationsUpdated>(_onRecommendationsUpdated);
  }

  final HomeDashboardRepository _repository;
  final RecommandationsRepository _recommandationsRepository;
  final ActionsRepository _actionsRepository;

  Future<void> _onLoadRequested(final HomeDashboardLoadRequested event, final Emitter<HomeDashboardState> emit) async {
    emit(const HomeDashboardState.loading());

    final resultDashboard = await _repository.fetch();

    await resultDashboard.fold(
      (final error) async =>
          emit(const HomeDashboardState.failure('Une erreur est survenue lors de la récupération du tableau de bord')),
      (final dashboard) async {
        final resultRecommendations = await _recommandationsRepository.fetchForHome();
        await resultRecommendations.fold(
          (final error) async => emit(const HomeDashboardState.failure('Erreur lors de la récupération des recommandations')),
          (final recommendations) async {
            final resultActions = await _actionsRepository.fetchForHome(areRecommendedActions: true);
            await resultActions.fold((final error) async {}, (final actions) async {
              emit(HomeDashboardState.success(homeDashboard: dashboard, actions: actions, recommendations: recommendations));
            });
          },
        );
      },
    );
  }

  Future<void> _onActionsSwitchRequested(
    final HomeDashboardActionsSwitchRequested event,
    final Emitter<HomeDashboardState> emit,
  ) async {
    final areRecommendedActions = event.areRecommendedActions;
    final resultActions = await _actionsRepository.fetchForHome(areRecommendedActions: areRecommendedActions);
    await resultActions.fold((final error) async {}, (final actions) async {
      emit(state.copyWith(areRecommendedActions: areRecommendedActions, actions: actions));
    });
  }

  Future<void> _onRecommendationsUpdated(
    final HomeDashboardRecommendationsUpdated event,
    final Emitter<HomeDashboardState> emit,
  ) async {
    final result = await _recommandationsRepository.fetchForHome();

    result.fold((final l) => emit(const HomeDashboardState.failure('Erreur lors de la récupération des recommandations')), (
      final r,
    ) {
      emit(state.copyWith(recommendations: r));
    });
  }
}
