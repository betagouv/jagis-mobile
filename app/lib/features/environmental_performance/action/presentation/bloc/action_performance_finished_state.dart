import 'package:app/features/environmental_performance/summary/domain/environmental_performance_detail_item.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ActionPerformanceFinishedState extends Equatable {
  const ActionPerformanceFinishedState();

  @override
  List<Object> get props => [];
}

@immutable
final class ActionPerformanceFinishedInitial extends ActionPerformanceFinishedState {
  const ActionPerformanceFinishedInitial();
}

@immutable
final class ActionPerformanceFinishedLoadInProgress extends ActionPerformanceFinishedState {
  const ActionPerformanceFinishedLoadInProgress();
}

@immutable
final class ActionPerformanceFinishedLoadSuccess extends ActionPerformanceFinishedState {
  const ActionPerformanceFinishedLoadSuccess(this.data);

  final EnvironmentalPerformanceDetailItem data;

  @override
  List<Object> get props => [data];
}

@immutable
final class ActionPerformanceFinishedLoadFailure extends ActionPerformanceFinishedState {
  const ActionPerformanceFinishedLoadFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
