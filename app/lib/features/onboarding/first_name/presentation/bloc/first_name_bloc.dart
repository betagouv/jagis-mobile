import 'package:app/core/error/domain/api_erreur.dart';
import 'package:app/features/onboarding/first_name/domain/first_name.dart';
import 'package:app/features/onboarding/first_name/infrastructure/first_name_repository.dart';
import 'package:app/features/onboarding/first_name/presentation/bloc/first_name_event.dart';
import 'package:app/features/onboarding/first_name/presentation/bloc/first_name_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstNameBloc extends Bloc<FirstNameEvent, FirstNameState> {
  FirstNameBloc({required final FirstNameRepository repository}) : _repository = repository, super(const FirstNameInitial()) {
    on<FirstNameChanged>(_onFirstNameChanged);
    on<FirstNameSubmitted>(_onFirstNameSubmitted);
  }

  final FirstNameRepository _repository;

  void _onFirstNameChanged(final FirstNameChanged event, final Emitter<FirstNameState> emit) =>
      FirstName.create(event.value).fold(
        (final l) => emit(FirstNameFailure(firstName: event.value, errorMessage: l)),
        (final r) => emit(FirstNameEntered(firstName: r.value, isValid: true)),
      );

  Future<void> _onFirstNameSubmitted(final FirstNameSubmitted event, final Emitter<FirstNameState> emit) async {
    final currentState = state;

    if (currentState is FirstNameEntered && currentState.isValid) {
      final firstName = FirstName.create(currentState.firstName);

      await firstName.fold(
        (final error) async => emit(FirstNameFailure(firstName: currentState.firstName, errorMessage: error)),
        (final firstNameValid) async {
          final result = await _repository.addFirstName(firstNameValid);

          result.fold(
            (final failure) => emit(
              FirstNameFailure(
                firstName: currentState.firstName,
                errorMessage: failure is ApiErreur ? failure.message : failure.toString(),
              ),
            ),
            (_) => emit(FirstNameSuccess(currentState.firstName)),
          );
        },
      );
    }
  }
}
