import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class SeConnecterEvent extends Equatable {
  const SeConnecterEvent();

  @override
  List<Object?> get props => [];
}

@immutable
final class SeConnecterAdresseMailAChange extends SeConnecterEvent {
  const SeConnecterAdresseMailAChange(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

@immutable
final class SeConnecterConnexionDemandee extends SeConnecterEvent {
  const SeConnecterConnexionDemandee();
}
