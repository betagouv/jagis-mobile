import 'package:app/features/theme/core/domain/theme_info.dart';
import 'package:app/features/theme/core/domain/theme_summary.dart';
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
  const ThemeLoadSuccess({required this.theme, required this.summary});

  final ThemeInfo theme;
  final ThemeSummary summary;

  ThemeLoadSuccess copyWith({final ThemeInfo? theme, final ThemeSummary? summary}) =>
      ThemeLoadSuccess(theme: theme ?? this.theme, summary: summary ?? this.summary);

  @override
  List<Object> get props => [theme, summary];
}

@immutable
final class ThemeLoadFailure extends ThemeState {
  const ThemeLoadFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
