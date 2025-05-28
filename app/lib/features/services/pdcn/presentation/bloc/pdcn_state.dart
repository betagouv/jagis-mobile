import 'package:app/features/services/pdcn/domain/pdcn_summary.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class PdcnState extends Equatable {
  const PdcnState();

  @override
  List<Object> get props => [];
}

@immutable
final class PdcnInitial extends PdcnState {
  const PdcnInitial();
}

@immutable
final class PdcnLoadInProgress extends PdcnState {
  const PdcnLoadInProgress();
}

@immutable
final class PdcnLoadSuccess extends PdcnState {
  const PdcnLoadSuccess({required this.list});

  final List<PdcnSummary> list;

  @override
  List<Object> get props => [list];
}

@immutable
final class PdcnLoadFailure extends PdcnState {
  const PdcnLoadFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
