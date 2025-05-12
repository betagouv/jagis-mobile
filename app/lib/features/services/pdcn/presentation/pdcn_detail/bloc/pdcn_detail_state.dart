import 'package:app/features/services/pdcn/domain/pdcn_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class PdcnDetailState extends Equatable {
  const PdcnDetailState();

  @override
  List<Object> get props => [];
}

@immutable
final class PdcnDetailInitial extends PdcnDetailState {
  const PdcnDetailInitial();
}

@immutable
final class PdcnDetailLoadInProgress extends PdcnDetailState {
  const PdcnDetailLoadInProgress();
}

@immutable
final class PdcnDetailLoadSuccess extends PdcnDetailState {
  const PdcnDetailLoadSuccess(this.detail);

  final PdcnDetail detail;

  @override
  List<Object> get props => [detail];
}

@immutable
final class PdcnDetailLoadFailure extends PdcnDetailState {
  const PdcnDetailLoadFailure();
}
