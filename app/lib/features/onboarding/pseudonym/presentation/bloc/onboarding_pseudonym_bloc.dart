import 'dart:async';

import 'package:app/core/error/domain/api_erreur.dart';
import 'package:app/features/onboarding/pseudonym/domain/pseudonym.dart';
import 'package:app/features/onboarding/pseudonym/infrastructure/onboarding_pseudonym_repository.dart';
import 'package:app/features/onboarding/pseudonym/presentation/bloc/onboarding_pseudonym_event.dart';
import 'package:app/features/onboarding/pseudonym/presentation/bloc/onboarding_pseudonym_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPseudonymBloc extends Bloc<OnboardingPseudonymEvent, OnboardingPseudonymState> {
  OnboardingPseudonymBloc(this._repository, final bool isUserFranceConnect)
    : super(OnboardingPseudonymState.initial(isUserFranceConnect)) {
    on<OnboardingPseudonymChanged>(_onPseudonymChanged);
    on<OnboardingBirthdateChanged>(_onBirthdateChanged);
    on<OnboardingPseudonymSubmitted>(_onSubmitted);
  }

  final OnboardingPseudonymRepository _repository;

  void _onPseudonymChanged(final OnboardingPseudonymChanged event, final Emitter<OnboardingPseudonymState> emit) {
    emit(state.setPseudonym(event.value));
    Pseudonym.create(event.value).fold((final l) => emit(state.fail(l)), (final r) => emit(state.setPseudonym(r.value)));
  }

  void _onBirthdateChanged(final OnboardingBirthdateChanged event, final Emitter<OnboardingPseudonymState> emit) {
    emit(state.setBirthdate(event.value));
  }

  Future<void> _onSubmitted(final OnboardingPseudonymSubmitted event, final Emitter<OnboardingPseudonymState> emit) async {
    final currentState = state;

    if (currentState.isValid) {
      final result = await _repository.savePseudonymAndBirthdate(currentState.pseudonym, currentState.birthdate);

      result.fold(
        (final failure) => emit(state.fail(failure is ApiErreur ? failure.message : failure.toString())),
        (_) => emit(state.submit()),
      );
    }
  }
}
