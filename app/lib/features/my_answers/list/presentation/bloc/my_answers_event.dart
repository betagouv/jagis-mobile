import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

@immutable
sealed class MyAnswersEvent extends Equatable {
  const MyAnswersEvent();

  @override
  List<Object?> get props => [];
}

@immutable
final class MyAnswersStarted extends MyAnswersEvent {
  const MyAnswersStarted();

  @override
  List<Object> get props => [];
}

@immutable
final class MyAnswersRefreshNeed extends MyAnswersEvent {
  const MyAnswersRefreshNeed();

  @override
  List<Object> get props => [];
}

@immutable
final class MyAnswersThemePressed extends MyAnswersEvent {
  const MyAnswersThemePressed(this.theme);

  final Option<ThemeType> theme;

  @override
  List<Object?> get props => [theme];
}
