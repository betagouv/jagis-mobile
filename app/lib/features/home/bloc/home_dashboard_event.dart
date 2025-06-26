import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class HomeDashboardEvent extends Equatable {
  const HomeDashboardEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class HomeDashboardLoadRequested extends HomeDashboardEvent {
  const HomeDashboardLoadRequested();
}

@immutable
final class HomeDashboardActionsSwitchRequested extends HomeDashboardEvent {
  const HomeDashboardActionsSwitchRequested(this.areRecommendedActions);

  final bool areRecommendedActions;

  @override
  List<Object> get props => [areRecommendedActions];
}

@immutable
final class HomeDashboardActionsRefreshRequested extends HomeDashboardEvent {
  const HomeDashboardActionsRefreshRequested();
}

@immutable
final class HomeDashboardRecommendationsUpdated extends HomeDashboardEvent {
  const HomeDashboardRecommendationsUpdated();
}
