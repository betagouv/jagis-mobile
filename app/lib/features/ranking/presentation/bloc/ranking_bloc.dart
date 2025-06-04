import 'dart:async';

import 'package:app/features/ranking/infrastructure/ranking_repository.dart';
import 'package:app/features/ranking/presentation/bloc/ranking_event.dart';
import 'package:app/features/ranking/presentation/bloc/ranking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  RankingBloc(this._repository) : super(const RankingInitial()) {
    on<RankingLoadRequested>(_onLoadRanking);
  }

  final RankingRepository _repository;

  Future<void> _onLoadRanking(final RankingLoadRequested event, final Emitter<RankingState> emit) async {
    emit(const RankingLoadInProgress());
    final localResult = await _repository.fetchLocalRanking();
    final nationalResult = await _repository.fetchNationalRanking();
    localResult.fold(
      (final error) => emit(const RankingLoadFailure('Erreur lors de la récupération du classement local')),
      (final local) => emit(
        RankingLoadSuccess(
          localRanking: local,
          nationalRanking: nationalResult.fold(
            (final error) => throw Exception('Erreur lors de la récupération du classement national'),
            (final national) => national,
          ),
        ),
      ),
    );
  }
}
