import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class PdcnEvent extends Equatable {
  const PdcnEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class PdcnLoadRequested extends PdcnEvent {
  const PdcnLoadRequested(this.category);

  final String category;

  @override
  List<Object> get props => [category];
}
