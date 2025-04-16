import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class PresDeChezVousEvent extends Equatable {
  const PresDeChezVousEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class PresDeChezVousLoadRequested extends PresDeChezVousEvent {
  const PresDeChezVousLoadRequested(this.category);

  final String category;

  @override
  List<Object> get props => [category];
}
