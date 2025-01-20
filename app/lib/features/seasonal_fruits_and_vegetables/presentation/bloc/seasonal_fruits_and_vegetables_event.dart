part of 'seasonal_fruits_and_vegetables_bloc.dart';

@immutable
sealed class SeasonalFruitsAndVegetablesEvent extends Equatable {
  const SeasonalFruitsAndVegetablesEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class SeasonalFruitsAndVegetablesFetch
    extends SeasonalFruitsAndVegetablesEvent {
  const SeasonalFruitsAndVegetablesFetch();
}
