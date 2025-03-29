import 'package:app/features/ranking/domain/ranking.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class RankingState extends Equatable {
  const RankingState();

  @override
  List<Object> get props => [];
}

@immutable
final class RankingInitial extends RankingState {
  const RankingInitial();
}

@immutable
final class RankingLoadInProgress extends RankingState {
  const RankingLoadInProgress();
}

@immutable
final class RankingLoadSuccess extends RankingState {
  const RankingLoadSuccess({required this.ranking});

  final Ranking ranking;

  @override
  List<Object> get props => [ranking];
}

@immutable
final class RankingLoadFailure extends RankingState {
  const RankingLoadFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
