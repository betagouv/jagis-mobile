import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ThemeHubEvent extends Equatable {
  const ThemeHubEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ThemeHubLoadRequested extends ThemeHubEvent {
  const ThemeHubLoadRequested();
}
