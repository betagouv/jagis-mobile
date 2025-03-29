import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class AchievementBadge extends Equatable {
  const AchievementBadge({required this.imageUrl, required this.title, required this.description});

  final String imageUrl;
  final String title;
  final String description;

  @override
  List<Object?> get props => [imageUrl, title, description];
}
