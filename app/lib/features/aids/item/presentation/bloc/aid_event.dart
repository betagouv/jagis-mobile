import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class AidEvent extends Equatable {
  const AidEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class AidSelectedById extends AidEvent {
  const AidSelectedById(this.aidId);

  final String aidId;

  @override
  List<Object> get props => [aidId];
}
