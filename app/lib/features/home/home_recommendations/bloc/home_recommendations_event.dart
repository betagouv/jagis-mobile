import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class HomeRecommendationsEvent extends Equatable {
  const HomeRecommendationsEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class HomeRecommendationsLoadRequested extends HomeRecommendationsEvent {
  const HomeRecommendationsLoadRequested();
}
