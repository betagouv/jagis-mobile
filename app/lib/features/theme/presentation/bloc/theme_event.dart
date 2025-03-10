import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ThemeFetchRequested extends ThemeEvent {
  const ThemeFetchRequested(this.themeType);

  final ThemeType themeType;

  @override
  List<Object> get props => [themeType];
}

@immutable
final class ThemeRefreshRequested extends ThemeEvent {
  const ThemeRefreshRequested();
}

@immutable
final class ThemeReplaceActionRequested extends ThemeEvent {
  const ThemeReplaceActionRequested(this.action);

  final ActionSummary action;

  @override
  List<Object> get props => [action];
}
