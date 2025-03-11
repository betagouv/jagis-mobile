import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class FirstNameState extends Equatable {
  const FirstNameState();

  @override
  List<Object> get props => [];
}

@immutable
final class FirstNameInitial extends FirstNameState {
  const FirstNameInitial();
}

@immutable
final class FirstNameEntered extends FirstNameState {
  const FirstNameEntered({required this.firstName, required this.isValid});

  final String firstName;
  final bool isValid;

  @override
  List<Object> get props => [firstName, isValid];
}

@immutable
final class FirstNameSuccess extends FirstNameState {
  const FirstNameSuccess(this.firstName);

  final String firstName;

  @override
  List<Object> get props => [firstName];
}

@immutable
final class FirstNameFailure extends FirstNameState {
  const FirstNameFailure({required this.firstName, required this.errorMessage});

  final String firstName;
  final String errorMessage;

  @override
  List<Object> get props => [firstName, errorMessage];
}
