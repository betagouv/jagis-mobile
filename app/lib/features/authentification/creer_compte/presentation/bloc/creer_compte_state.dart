import 'package:app/core/helpers/regex.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

@immutable
final class CreerCompteState extends Equatable {
  const CreerCompteState({required this.email, required this.errorMessage, required this.isAccountCreated});

  const CreerCompteState.empty() : this(email: '', errorMessage: const None(), isAccountCreated: false);

  final String email;
  final Option<String> errorMessage;
  bool get isEmailValid => mailRegex.hasMatch(email);
  bool get isAccountValid => isEmailValid;
  final bool isAccountCreated;

  CreerCompteState copyWith({final String? email, final Option<String>? errorMessage, final bool? isAccountCreated}) =>
      CreerCompteState(
        email: email ?? this.email,
        errorMessage: errorMessage ?? this.errorMessage,
        isAccountCreated: isAccountCreated ?? this.isAccountCreated,
      );

  @override
  List<Object> get props => [email, errorMessage, isAccountCreated];
}
