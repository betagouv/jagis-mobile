import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class WinterActionsEvent extends Equatable {
  const WinterActionsEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class WinterActionsLoadRequested extends WinterActionsEvent {
  const WinterActionsLoadRequested();
}
