import 'package:app/features/home/home_recommendations/bloc/home_recommendations_event.dart';
import 'package:app/features/home/home_recommendations/bloc/home_recommendations_state.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/recommandations/infrastructure/recommandations_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeRecommendationsBloc extends Bloc<HomeRecommendationsEvent, HomeRecommendationsState> {
  HomeRecommendationsBloc({required final RecommandationsRepository repository}) : super(const HomeRecommendationsInitial()) {
    on<HomeRecommendationsLoadRequested>((final event, final emit) async {
      emit(const HomeRecommendationsLoadInProgress());

      final result = await repository.recupererV3(maxItem: 4, type: TypeDuContenu.article);

      result.fold((final l) => emit(HomeRecommendationsLoadFailure(errorMessage: l.toString())), (final r) {
        emit(HomeRecommendationsLoadSuccess(r));
      });
    });
  }
}
