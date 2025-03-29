import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class RankingEvent extends Equatable {
  const RankingEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class RankingLoadRequested extends RankingEvent {
  const RankingLoadRequested();
}
