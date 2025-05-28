import 'package:app/features/services/lvao/domain/lvao_actor.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class LvaoDetailState extends Equatable {
  const LvaoDetailState();

  @override
  List<Object> get props => [];
}

@immutable
final class LvaoDetailInitial extends LvaoDetailState {
  const LvaoDetailInitial();
}

@immutable
final class LvaoDetailLoadInProgress extends LvaoDetailState {
  const LvaoDetailLoadInProgress();
}

@immutable
final class LvaoDetailLoadSuccess extends LvaoDetailState {
  const LvaoDetailLoadSuccess(this.detail);

  final LvaoActor detail;

  @override
  List<Object> get props => [detail];
}

@immutable
final class LvaoDetailLoadFailure extends LvaoDetailState {
  const LvaoDetailLoadFailure();
}
