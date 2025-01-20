part of 'seasonal_fruits_and_vegetables_bloc.dart';

@immutable
sealed class SeasonalFruitsAndVegetablesState extends Equatable {
  const SeasonalFruitsAndVegetablesState();

  @override
  List<Object> get props => [];
}

@immutable
final class SeasonalFruitsAndVegetablesInitial
    extends SeasonalFruitsAndVegetablesState {
  const SeasonalFruitsAndVegetablesInitial();
}

@immutable
final class SeasonalFruitsAndVegetablesLoadInProgress
    extends SeasonalFruitsAndVegetablesState {
  const SeasonalFruitsAndVegetablesLoadInProgress();
}

@immutable
final class SeasonalFruitsAndVegetablesLoadSuccess
    extends SeasonalFruitsAndVegetablesState {
  const SeasonalFruitsAndVegetablesLoadSuccess(this.months);

  final List<SeasonalFruitsAndVegetablesMonth> months;
}

@immutable
final class SeasonalFruitsAndVegetablesLoadFailure
    extends SeasonalFruitsAndVegetablesState {
  const SeasonalFruitsAndVegetablesLoadFailure(this.error);

  final String error;
}
