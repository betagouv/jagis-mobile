import 'package:app/features/ranking/domain/achievement_badge.dart';

class AchievementBadgeDto extends AchievementBadge {
  const AchievementBadgeDto({required super.imageUrl, required super.title, required super.description});

  factory AchievementBadgeDto.fromJson(final Map<String, dynamic> json) => AchievementBadgeDto(
    imageUrl: json['image_url'] as String,
    title: json['titre'] as String,
    description: json['description'] as String,
  );
}
