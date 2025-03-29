import 'package:app/features/ranking/domain/achievement_badge.dart';
import 'package:app/features/ranking/domain/user_rank.dart';
import 'package:equatable/equatable.dart';

class Ranking extends Equatable {
  const Ranking({
    required this.topThree,
    required this.user,
    required this.userRanking,
    required this.percentile,
    this.postalCode,
    this.communeLabel,
    required this.badges,
  });

  final List<UserRank> topThree;
  final UserRank user;
  final List<UserRank> userRanking;
  final String percentile;
  final String? postalCode;
  final String? communeLabel;
  final List<AchievementBadge> badges;

  @override
  List<Object?> get props => [topThree, user, userRanking, percentile, postalCode, communeLabel, badges];
}
