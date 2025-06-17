import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class AchievementBadge extends Equatable {
  AchievementBadge.fromJson(final Map<String, dynamic> json)
    : imageUrl = json['image_url'] as String,
      title = json['titre'] as String,
      description = json['description'] as String;

  final String imageUrl;
  final String title;

  final String description;

  @override
  List<Object?> get props => [imageUrl, title, description];
}
