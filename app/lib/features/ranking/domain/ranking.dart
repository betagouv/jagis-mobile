import 'package:app/features/ranking/domain/achievement_badge.dart';
import 'package:app/features/ranking/domain/user_rank.dart';
import 'package:equatable/equatable.dart';

class Ranking extends Equatable {
  Ranking.fromJson(final Map<String, dynamic> json)
    : topThree = (json['top_trois'] as List<dynamic>).map((final e) => UserRank.fromJson(e as Map<String, dynamic>)).toList(),
      user = UserRank.fromJson(json['utilisateur'] as Map<String, dynamic>),
      userRanking = (json['classement_utilisateur'] as List<dynamic>)
          .map((final e) => UserRank.fromJson(e as Map<String, dynamic>))
          .toList(),
      postalCode = json['code_postal'] as String?,
      communeLabel = json['commune_label'] as String?,
      badges = (json['badges'] as List<dynamic>).map((final e) => AchievementBadge.fromJson(e as Map<String, dynamic>)).toList();

  final List<UserRank> topThree;
  final UserRank user;
  final List<UserRank> userRanking;
  final String? postalCode;
  final String? communeLabel;

  final List<AchievementBadge> badges;

  @override
  List<Object?> get props => [topThree, user, userRanking, postalCode, communeLabel, badges];
}
