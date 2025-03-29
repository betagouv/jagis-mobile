import 'dart:async';

import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/authentication/domain/authentication_status.dart';
import 'package:app/features/gamification/domain/gamification.dart';
import 'package:app/features/gamification/infrastructure/gamification_repository.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_event.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamificationBloc extends Bloc<GamificationEvent, GamificationState> {
  GamificationBloc(final GamificationRepository repository, final AuthenticationService authenticationService)
    : super(const GamificationState.empty()) {
    on<GamificationAuthenticationChanged>((final event, final emit) async {
      if (event.status is Authenticated) {
        await repository.refresh();
      }
    });
    on<GamificationSubscriptionRequested>((final event, final emit) async {
      emit(state.copyWith(statut: GamificationStatut.chargement));

      await emit.forEach<Gamification>(
        repository.gamification(),
        onData: (final data) => state.copyWith(statut: GamificationStatut.succes, points: data.points, badges: data.badges),
        onError: (final _, final _) => state.copyWith(statut: GamificationStatut.erreur),
      );
    });
    _subscription = authenticationService.authenticationStatus.listen(
      (final statut) => add(GamificationAuthenticationChanged(statut)),
    );
  }

  late final StreamSubscription<AuthenticationStatus> _subscription;

  @override
  Future<void> close() {
    _subscription.cancel();

    return super.close();
  }
}
