import 'package:app/features/home/domain/home_dashboard.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// TODO(erolley): add an abstract class for each state using this status enum framework
enum HomeDashboardStateStatus { init, loading, success, failure }

@immutable
class HomeDashboardState extends Equatable {
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

  @override
  List<Object?> get props => [statut, errorMessage, homeDashboard, recommendations];
}
