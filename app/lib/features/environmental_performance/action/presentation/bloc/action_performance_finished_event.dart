import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ActionPerformanceFinishedEvent extends Equatable {
  const ActionPerformanceFinishedEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ActionPerformanceFinishedLoadRequested extends ActionPerformanceFinishedEvent {
  const ActionPerformanceFinishedLoadRequested(this.type);

  final ThemeType type;

  @override
  List<Object> get props => [type];
}
