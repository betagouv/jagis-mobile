import 'package:app/core/helpers/regex.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

@immutable
final class SeConnecterState extends Equatable {
  const SeConnecterState({required this.email, required this.errorMessage, required this.isConnected});

  const SeConnecterState.empty() : this(email: '', errorMessage: const None(), isConnected: false);

  final String email;
  final Option<String> errorMessage;

  bool get isEmailValid => mailRegex.hasMatch(email);
  bool get isValid => isEmailValid;

  final bool isConnected;

  SeConnecterState copyWith({final String? email, final Option<String>? errorMessage, final bool? isConnected}) =>
      SeConnecterState(
        email: email ?? this.email,
        errorMessage: errorMessage ?? this.errorMessage,
        isConnected: isConnected ?? this.isConnected,
      );

  @override
  List<Object?> get props => [email, isConnected, errorMessage];
}
