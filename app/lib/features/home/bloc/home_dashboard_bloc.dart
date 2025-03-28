import 'package:app/features/home/bloc/home_dashboard_event.dart';
import 'package:app/features/home/bloc/home_dashboard_state.dart';
import 'package:app/features/home/infrastructure/home_dashboard_repository.dart';
import 'package:app/features/recommandations/infrastructure/recommandations_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDashboardBloc extends Bloc<HomeDashboardEvent, HomeDashboardState> {
  HomeDashboardBloc(final HomeDashboardRepository repository, final RecommandationsRepository recommandationsRepository)
    : super(const HomeDashboardState.init()) {
    on<HomeDashboardLoadRequested>((final event, final emit) async {
      emit(const HomeDashboardState.loading());

      final resultDashboard = await repository.fetch();

      await resultDashboard.fold(
        (final l) async =>
            emit(const HomeDashboardState.failure('Une erreur est survenue lors de la récupération du tableau de bord')),
        (final dashboard) async {
          final resultRecommendations = await recommandationsRepository.fetchForHome();
          resultRecommendations.fold(
            (final l) => emit(const HomeDashboardState.failure('Erreur lors de la récupération des recommandations')),
            (final recommandations) {
              emit(HomeDashboardState.success(homeDashboard: dashboard, recommendations: recommandations));
            },
          );
        },
      );
    });
    on<HomeDashboardRecommandationsUpdated>((final event, final emit) async {
      final result = await recommandationsRepository.fetchForHome();

      result.fold((final l) => emit(const HomeDashboardState.failure('Erreur lors de la récupération des recommandations')), (
        final r,
      ) {
        emit(state.copyWith(recommendations: r));
      });
    });
  }
}
