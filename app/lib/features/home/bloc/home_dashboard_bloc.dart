import 'package:app/features/home/bloc/home_dashboard_event.dart';
import 'package:app/features/home/bloc/home_dashboard_state.dart';
import 'package:app/features/home/infrastructure/home_dashboard_repository.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/recommandations/infrastructure/recommandations_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class HomeDashboardBloc extends Bloc<HomeDashboardEvent, HomeDashboardState> {
  HomeDashboardBloc({
    required final HomeDashboardRepository repository,
    required final RecommandationsRepository recommandationsRepository,
  }) : super(const HomeDashboardState.init()) {
    on<HomeDashboardLoadRequested>((final event, final emit) async {
      emit(const HomeDashboardState.loading());

      final resultDashboard = await repository.fetch();

      if (resultDashboard.isLeft()) {
        emit(
          HomeDashboardState.failure(
            resultDashboard
                .getLeft()
                .map((final l) => 'Une erreur est survenue lors de la récupération du tableau de bord: $l')
                .getOrElse(() => 'Une erreur est survenue lors de la récupération du tableau de bord'),
          ),
        );

        return;
      }

      final dashboard = resultDashboard.getRight().getOrElse(() => throw Exception('Unexpected error'));

      final resultRecommendations = await recommandationsRepository.recupererV3(maxItem: 4, type: TypeDuContenu.article);

      resultRecommendations.fold(
        (final l) => emit(HomeDashboardState.failure('Erreur lors de la récupération des recommandations: $l')),
        (final r) {
          emit(HomeDashboardState.success(homeDashboard: dashboard, recommendations: r));
        },
      );
    });
  }
}
