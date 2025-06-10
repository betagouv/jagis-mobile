import 'package:app/features/home/domain/home_dashboard.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum HomeDashboardStateStatus { init, loading, success, failure }

@immutable
final class HomeDashboardState extends Equatable {
  const HomeDashboardState({required this.statut, this.homeDashboard, this.recommendations, this.errorMessage});
  const HomeDashboardState.init() : this(statut: HomeDashboardStateStatus.init);
  const HomeDashboardState.loading() : this(statut: HomeDashboardStateStatus.loading);
  const HomeDashboardState.failure(final String errorMessage)
    : this(statut: HomeDashboardStateStatus.failure, errorMessage: errorMessage);
  const HomeDashboardState.success({
    required final HomeDashboard homeDashboard,
    required final List<Recommandation> recommendations,
  }) : this(statut: HomeDashboardStateStatus.success, homeDashboard: homeDashboard, recommendations: recommendations);

  final HomeDashboardStateStatus statut;
  final String? errorMessage;
  final HomeDashboard? homeDashboard;
  final List<Recommandation>? recommendations;

  HomeDashboardState copyWith({
    final HomeDashboardStateStatus? statut,
    final String? errorMessage,
    final HomeDashboard? homeDashboard,
    final List<Recommandation>? recommendations,
  }) => HomeDashboardState(
    statut: statut ?? this.statut,
    homeDashboard: homeDashboard ?? this.homeDashboard,
    recommendations: recommendations ?? this.recommendations,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [statut, errorMessage, homeDashboard, recommendations];
}
