import 'package:app/core/error/domain/api_erreur.dart';
import 'package:app/features/onboarding/pseudonym/domain/pseudonym.dart';
import 'package:app/features/onboarding/pseudonym/infrastructure/onboarding_pseudonym_repository.dart';
import 'package:app/features/onboarding/pseudonym/presentation/bloc/onboarding_pseudonym_event.dart';
import 'package:app/features/onboarding/pseudonym/presentation/bloc/onboarding_pseudonym_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPseudonymBloc extends Bloc<OnboardingPseudonymEvent, OnboardingPseudonymState> {
  OnboardingPseudonymBloc({required final OnboardingPseudonymRepository repository})
    : _repository = repository,
      super(const OnboardingPseudonymInitial()) {
    on<OnboardingPseudonymChanged>(_onOnboardingPseudonymChanged);
    on<OnboardingPseudonymSubmitted>(_onOnboardingPseudonymSubmitted);
  }

  final OnboardingPseudonymRepository _repository;

  void _onOnboardingPseudonymChanged(final OnboardingPseudonymChanged event, final Emitter<OnboardingPseudonymState> emit) =>
      Pseudonym.create(event.value).fold(
        (final l) => emit(OnboardingPseudonymFailure(pseudonym: event.value, errorMessage: l)),
        (final r) => emit(OnboardingPseudonymEntered(pseudonym: r.value, isValid: true)),
      );

  Future<void> _onOnboardingPseudonymSubmitted(
    final OnboardingPseudonymSubmitted event,
    final Emitter<OnboardingPseudonymState> emit,
  ) async {
    final currentState = state;

    if (currentState is OnboardingPseudonymEntered && currentState.isValid) {
      final pseudonym = Pseudonym.create(currentState.pseudonym);

      await pseudonym.fold(
        (final error) async => emit(OnboardingPseudonymFailure(pseudonym: currentState.pseudonym, errorMessage: error)),
        (final pseudonymValid) async {
          final result = await _repository.addPseudonym(pseudonymValid);

          result.fold(
            (final failure) => emit(
              OnboardingPseudonymFailure(
                pseudonym: currentState.pseudonym,
                errorMessage: failure is ApiErreur ? failure.message : failure.toString(),
              ),
            ),
            (_) => emit(OnboardingPseudonymSuccess(currentState.pseudonym)),
          );
        },
      );
    }
  }
}
