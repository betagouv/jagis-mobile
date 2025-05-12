import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class PdcnDetailEvent extends Equatable {
  const PdcnDetailEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class PdcnDetailLoadRequested extends PdcnDetailEvent {
  const PdcnDetailLoadRequested(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}
