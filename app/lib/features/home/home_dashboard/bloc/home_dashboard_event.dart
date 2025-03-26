import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class HomeDashboardEvent extends Equatable {
  const HomeDashboardEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class HomeDashboardLoadRequested extends HomeDashboardEvent {
  const HomeDashboardLoadRequested();
}
