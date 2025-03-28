import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum GamificationStatut { initial, chargement, succes, erreur }

@immutable
final class GamificationState extends Equatable {
  const GamificationState({required this.statut, required this.points, required this.badges});
  const GamificationState.empty() : this(statut: GamificationStatut.initial, points: 0, badges: 0);

  final GamificationStatut statut;
  final int points;
  final int badges;

  GamificationState copyWith({final GamificationStatut? statut, final int? points, final int? badges}) =>
      GamificationState(statut: statut ?? this.statut, points: points ?? this.points, badges: badges ?? this.badges);

  @override
  List<Object> get props => [statut, points, badges];
}
