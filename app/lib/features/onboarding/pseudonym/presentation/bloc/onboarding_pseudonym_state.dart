import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class OnboardingPseudonymState extends Equatable {
  const OnboardingPseudonymState();

  @override
  List<Object> get props => [];
}

@immutable
final class OnboardingPseudonymInitial extends OnboardingPseudonymState {
  const OnboardingPseudonymInitial();
}

@immutable
final class OnboardingPseudonymEntered extends OnboardingPseudonymState {
  const OnboardingPseudonymEntered({required this.pseudonym, required this.isValid});

  final String pseudonym;
  final bool isValid;

  @override
  List<Object> get props => [pseudonym, isValid];
}

@immutable
final class OnboardingPseudonymSuccess extends OnboardingPseudonymState {
  const OnboardingPseudonymSuccess(this.pseudonym);

  final String pseudonym;

  @override
  List<Object> get props => [pseudonym];
}

@immutable
final class OnboardingPseudonymFailure extends OnboardingPseudonymState {
  const OnboardingPseudonymFailure({required this.pseudonym, required this.errorMessage});

  final String pseudonym;
  final String errorMessage;

  @override
  List<Object> get props => [pseudonym, errorMessage];
}
