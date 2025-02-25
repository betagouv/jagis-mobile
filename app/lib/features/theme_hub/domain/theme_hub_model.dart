import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

class ThemeHubModel extends Equatable {
  const ThemeHubModel({required this.city, required this.themes});

  final String city;
  final List<ThemeHubThemeSummary> themes;

  @override
  List<Object?> get props => [city, themes];
}

class ThemeHubThemeSummary extends Equatable {
  const ThemeHubThemeSummary({required this.themeType, required this.details});

  final ThemeType themeType;
  final Map<ThemeHubDetailType, int> details;

  @override
  List<Object?> get props => [themeType, details];
}

enum ThemeHubDetailType { action, aid, recipe, simulator }
