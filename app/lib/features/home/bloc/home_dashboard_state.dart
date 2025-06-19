import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/home/domain/home_dashboard.dart';
import 'package:app/features/recommandations/domain/recommendation.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum HomeDashboardStateStatus { init, loading, success, failure }

@immutable
final class HomeDashboardState extends Equatable {
  const HomeDashboardState({
    required this.statut,
    this.homeDashboard,
    this.areRecommendedActions = true,
    this.actions = const [],
    this.recommendations = const [],
    this.errorMessage,
  });
  const HomeDashboardState.init() : this(statut: HomeDashboardStateStatus.init);
  const HomeDashboardState.loading() : this(statut: HomeDashboardStateStatus.loading);
  const HomeDashboardState.failure(final String errorMessage)
    : this(statut: HomeDashboardStateStatus.failure, errorMessage: errorMessage);
  const HomeDashboardState.success({
    required final HomeDashboard homeDashboard,
    required final List<ActionSummary> actions,
    required final List<Recommendation> recommendations,
  }) : this(
         statut: HomeDashboardStateStatus.success,
         homeDashboard: homeDashboard,
         actions: actions,
         recommendations: recommendations,
       );

  final HomeDashboardStateStatus statut;
  final HomeDashboard? homeDashboard;
  final bool areRecommendedActions;
  final List<ActionSummary> actions;
  final List<Recommendation> recommendations;
  final String? errorMessage;

  HomeDashboardState copyWith({
    final HomeDashboardStateStatus? statut,
    final String? errorMessage,
    final HomeDashboard? homeDashboard,
    final bool? areRecommendedActions,
    final List<ActionSummary>? actions,
    final List<Recommendation>? recommendations,
  }) => HomeDashboardState(
    statut: statut ?? this.statut,
    homeDashboard: homeDashboard ?? this.homeDashboard,
    areRecommendedActions: areRecommendedActions ?? this.areRecommendedActions,
    actions: actions ?? this.actions,
    recommendations: recommendations ?? this.recommendations,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [statut, errorMessage, homeDashboard, areRecommendedActions, actions, recommendations];
}
