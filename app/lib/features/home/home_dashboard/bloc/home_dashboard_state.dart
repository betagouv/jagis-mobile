import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class HomeDashboardState extends Equatable {
  const HomeDashboardState();

  @override
  List<Object?> get props => [];
}

@immutable
final class HomeDashboardInitial extends HomeDashboardState {
  const HomeDashboardInitial();
}

@immutable
final class HomeDashboardLoadInProgress extends HomeDashboardState {
  const HomeDashboardLoadInProgress();
}

@immutable
final class HomeDashboardLoadSuccess extends HomeDashboardState {
  const HomeDashboardLoadSuccess({required this.nbActionsDone, required this.bilanCarbonePercentageCompletion});

  final int nbActionsDone;
  final int bilanCarbonePercentageCompletion;

  @override
  List<Object?> get props => [nbActionsDone, bilanCarbonePercentageCompletion];
}

@immutable
final class HomeDashboardLoadFailure extends HomeDashboardState {
  const HomeDashboardLoadFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
