import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/domain/service_item.dart';
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
  const ThemeLoadSuccess({required this.theme, required this.missions, required this.services});

  final ThemeInfo theme;
  final List<MissionListe> missions;
  final List<ServiceItem> services;

  @override
  List<Object> get props => [theme, missions, services];
}

@immutable
final class ThemeLoadFailure extends ThemeState {
  const ThemeLoadFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
