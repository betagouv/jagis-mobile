import 'package:app/features/ranking/domain/ranking.dart';
import 'package:app/features/ranking/infrastructure/achievement_badge_dto.dart';
import 'package:app/features/ranking/infrastructure/user_rank_dto.dart';

class RankingDto extends Ranking {
  const RankingDto({
    required super.topThree,
    required super.user,
    required super.userRanking,
    required super.percentile,
    super.postalCode,
    super.communeLabel,
    required super.badges,
  });

  factory RankingDto.fromJson(final Map<String, dynamic> json) => RankingDto(
    topThree: (json['top_trois'] as List<dynamic>).map((final e) => UserRankDto.fromJson(e as Map<String, dynamic>)).toList(),
    user: UserRankDto.fromJson(json['utilisateur'] as Map<String, dynamic>),
    userRanking:
        (json['classement_utilisateur'] as List<dynamic>)
            .map((final e) => UserRankDto.fromJson(e as Map<String, dynamic>))
            .toList(),
    percentile: json['pourcentile'] as String,
    postalCode: json['code_postal'] as String?,
    communeLabel: json['commune_label'] as String?,
    badges: (json['badges'] as List<dynamic>).map((final e) => AchievementBadgeDto.fromJson(e as Map<String, dynamic>)).toList(),
  );
}
