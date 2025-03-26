import 'package:app/core/authentication/domain/authentication_status.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class GamificationEvent extends Equatable {
  const GamificationEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class GamificationAuthenticationChanged extends GamificationEvent {
  const GamificationAuthenticationChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

@immutable
final class GamificationSubscriptionRequested extends GamificationEvent {
  const GamificationSubscriptionRequested();
}
