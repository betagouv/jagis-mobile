import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class WinterEvent extends Equatable {
  const WinterEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class WinterStarted extends WinterEvent {
  const WinterStarted();
}

@immutable
final class WinterAddressChanged extends WinterEvent {
  const WinterAddressChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

@immutable
final class WinterLastNameChanged extends WinterEvent {
  const WinterLastNameChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

@immutable
final class WinterDeclarationChanged extends WinterEvent {
  const WinterDeclarationChanged(this.value);

  final bool value;

  @override
  List<Object> get props => [value];
}

@immutable
final class WinterSubmit extends WinterEvent {
  const WinterSubmit();

  @override
  List<Object> get props => [];
}
