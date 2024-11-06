import 'package:app/features/aides/core/domain/aide.dart';
import 'package:equatable/equatable.dart';

final class AideState extends Equatable {
  const AideState(this.aide);

  final Assistance aide;

  @override
  List<Object> get props => [aide];
}
