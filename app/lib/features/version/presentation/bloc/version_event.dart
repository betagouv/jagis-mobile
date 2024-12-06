import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class VersionEvent extends Equatable {
  const VersionEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class VersionDemandee extends VersionEvent {
  const VersionDemandee();
}
