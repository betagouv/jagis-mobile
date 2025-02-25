import 'package:app/features/theme_hub/domain/theme_hub_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ThemeHubState extends Equatable {
  const ThemeHubState();

  @override
  List<Object> get props => [];
}

@immutable
final class ThemeHubInitial extends ThemeHubState {
  const ThemeHubInitial();
}

@immutable
final class ThemeHubLoadInProgress extends ThemeHubState {
  const ThemeHubLoadInProgress();
}

@immutable
final class ThemeHubLoadSuccess extends ThemeHubState {
  const ThemeHubLoadSuccess({required this.model});

  final ThemeHubModel model;

  @override
  List<Object> get props => [model];
}

@immutable
final class ThemeHubLoadFailure extends ThemeHubState {
  const ThemeHubLoadFailure();
}
