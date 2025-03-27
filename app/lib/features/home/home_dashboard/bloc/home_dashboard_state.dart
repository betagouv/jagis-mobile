import 'package:app/features/home/home_dashboard/domain/home_dashboard.dart';
import 'package:equatable/equatable.dart';

// TODO(erolley): add an abstract class for each state using this status enum framework
enum HomeDashboardStateStatus { init, loading, success, failure }

class HomeDashboardState extends Equatable {
  const HomeDashboardState({required this.statut, this.homeDashboard, this.errorMessage});
  const HomeDashboardState.init() : this(statut: HomeDashboardStateStatus.init);
  const HomeDashboardState.loading() : this(statut: HomeDashboardStateStatus.loading);
  const HomeDashboardState.success(final HomeDashboard homeDashboard)
    : this(statut: HomeDashboardStateStatus.success, homeDashboard: homeDashboard);
  const HomeDashboardState.failure(final String errorMessage)
    : this(statut: HomeDashboardStateStatus.failure, errorMessage: errorMessage);

  final HomeDashboardStateStatus statut;
  final String? errorMessage;
  final HomeDashboard? homeDashboard;

  @override
  List<Object?> get props => [statut, errorMessage, homeDashboard];
}
