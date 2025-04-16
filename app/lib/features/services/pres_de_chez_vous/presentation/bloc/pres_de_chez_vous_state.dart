import 'package:app/features/services/pres_de_chez_vous/domain/pres_de_chez_vous_summary.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class PresDeChezVousState extends Equatable {
  const PresDeChezVousState();

  @override
  List<Object> get props => [];
}

@immutable
final class PresDeChezVousInitial extends PresDeChezVousState {
  const PresDeChezVousInitial();
}

@immutable
final class PresDeChezVousLoadInProgress extends PresDeChezVousState {
  const PresDeChezVousLoadInProgress();
}

@immutable
final class PresDeChezVousLoadSuccess extends PresDeChezVousState {
  const PresDeChezVousLoadSuccess({required this.list});

  final List<PresDeChezVousSummary> list;

  @override
  List<Object> get props => [list];
}

@immutable
final class PresDeChezVousLoadFailure extends PresDeChezVousState {
  const PresDeChezVousLoadFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
