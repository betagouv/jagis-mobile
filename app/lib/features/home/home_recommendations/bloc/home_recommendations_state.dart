import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// TODO(erolley): seems there is something to factorize here with all other bloc of the same kind
@immutable
sealed class HomeRecommendationsState extends Equatable {
  const HomeRecommendationsState();

  @override
  List<Object?> get props => [];
}

@immutable
final class HomeRecommendationsInitial extends HomeRecommendationsState {
  const HomeRecommendationsInitial();
}

@immutable
final class HomeRecommendationsLoadInProgress extends HomeRecommendationsState {
  const HomeRecommendationsLoadInProgress();
}

@immutable
final class HomeRecommendationsLoadSuccess extends HomeRecommendationsState {
  const HomeRecommendationsLoadSuccess(this.recommendations);

  final List<Recommandation> recommendations;

  @override
  List<Object?> get props => [recommendations];
}

@immutable
final class HomeRecommendationsLoadFailure extends HomeRecommendationsState {
  const HomeRecommendationsLoadFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
