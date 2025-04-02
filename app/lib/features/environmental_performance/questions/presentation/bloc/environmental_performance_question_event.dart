import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class EnvironmentalPerformanceQuestionEvent extends Equatable {
  const EnvironmentalPerformanceQuestionEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class EnvironmentalPerformanceQuestionIdListRequested extends EnvironmentalPerformanceQuestionEvent {
  const EnvironmentalPerformanceQuestionIdListRequested(this.categoryId);

  final String categoryId;

  @override
  List<Object> get props => [categoryId];
}
