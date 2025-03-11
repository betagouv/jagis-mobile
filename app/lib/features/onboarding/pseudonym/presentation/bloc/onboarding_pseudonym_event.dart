import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class OnboardingPseudonymEvent extends Equatable {
  const OnboardingPseudonymEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class OnboardingPseudonymChanged extends OnboardingPseudonymEvent {
  const OnboardingPseudonymChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

@immutable
final class OnboardingPseudonymSubmitted extends OnboardingPseudonymEvent {
  const OnboardingPseudonymSubmitted();
}
