import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:equatable/equatable.dart';

enum HomeRecommendationsStatut { init, loading, success, failure }

class HomeRecommendationsState extends Equatable {
  const HomeRecommendationsState({required this.statut, this.recommendations, this.errorMessage});
  const HomeRecommendationsState.init() : this(statut: HomeRecommendationsStatut.init);
  const HomeRecommendationsState.loading() : this(statut: HomeRecommendationsStatut.loading);
  const HomeRecommendationsState.success(final List<Recommandation> recommendations)
    : this(statut: HomeRecommendationsStatut.success, recommendations: recommendations);
  const HomeRecommendationsState.failure(final String errorMessage)
    : this(statut: HomeRecommendationsStatut.failure, errorMessage: errorMessage);

  final HomeRecommendationsStatut statut;
  final List<Recommandation>? recommendations;
  final String? errorMessage;

  @override
  List<Object?> get props => [statut, recommendations, errorMessage];
}
