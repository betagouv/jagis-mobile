import 'package:app/features/aids/core/domain/aid_summary.dart';
import 'package:app/features/recommandations/domain/recommendation.dart';
import 'package:app/features/theme/core/domain/theme_info.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

@immutable
final class ThemeInitial extends ThemeState {
  const ThemeInitial();
}

@immutable
final class ThemeLoadInProgress extends ThemeState {
  const ThemeLoadInProgress();
}

@immutable
final class ThemeLoadSuccess extends ThemeState {
  const ThemeLoadSuccess({required this.themeInfo, required this.aids, required this.recommendations});

  final ThemeInfo themeInfo;
  final List<AidSummary> aids;
  final List<Recommendation> recommendations;

  ThemeLoadSuccess copyWith({
    final ThemeInfo? themeInfo,
    final List<AidSummary>? aids,
    final List<Recommendation>? recommendations,
  }) => ThemeLoadSuccess(
    themeInfo: themeInfo ?? this.themeInfo,
    aids: aids ?? this.aids,
    recommendations: recommendations ?? this.recommendations,
  );

  @override
  List<Object> get props => [themeInfo, aids, recommendations];
}

@immutable
final class ThemeLoadFailure extends ThemeState {
  const ThemeLoadFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
