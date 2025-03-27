import 'package:app/features/onboarding/pseudonym/domain/pseudonym.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class OnboardingPseudonymState extends Equatable {
  const OnboardingPseudonymState._({
    required this.isUserFranceConnect,
    required this.pseudonym,
    this.birthdate,
    this.isSuccess = false,
    this.errorMessage,
  });
  const OnboardingPseudonymState.initial(final bool isUserFranceConnect)
    : this._(isUserFranceConnect: isUserFranceConnect, pseudonym: '');

  final bool isUserFranceConnect;
  final String pseudonym;
  final DateTime? birthdate;
  bool get isValid => pseudonym.isNotEmpty && (isUserFranceConnect || birthdate != null) && errorMessage == null;
  final bool isSuccess;
  final String? errorMessage;

  OnboardingPseudonymState setPseudonym(final String pseudonym) => Pseudonym.create(pseudonym).fold(
    fail,
    (final r) => OnboardingPseudonymState._(isUserFranceConnect: isUserFranceConnect, pseudonym: pseudonym, birthdate: birthdate),
  );

  OnboardingPseudonymState setBirthdate(final DateTime birthdate) =>
      OnboardingPseudonymState._(isUserFranceConnect: isUserFranceConnect, pseudonym: pseudonym, birthdate: birthdate);

  OnboardingPseudonymState submit() => OnboardingPseudonymState._(
    isUserFranceConnect: isUserFranceConnect,
    pseudonym: pseudonym,
    birthdate: birthdate,
    isSuccess: true,
  );

  OnboardingPseudonymState fail(final String errorMessage) =>
      OnboardingPseudonymState._(isUserFranceConnect: isUserFranceConnect, pseudonym: pseudonym, errorMessage: errorMessage);

  @override
  List<Object?> get props => [isUserFranceConnect, pseudonym, birthdate, isSuccess, errorMessage];
}
