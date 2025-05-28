import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class LvaoDetailEvent extends Equatable {
  const LvaoDetailEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class LvaoDetailLoadRequested extends LvaoDetailEvent {
  const LvaoDetailLoadRequested(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}
