import 'package:app/core/helpers/regex.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class MotDePasseOublieState extends Equatable {
  const MotDePasseOublieState({required this.email});

  final String email;
  bool get emailEstValide => mailRegex.hasMatch(email);

  MotDePasseOublieState copyWith({final String? email}) => MotDePasseOublieState(email: email ?? this.email);

  @override
  List<Object> get props => [email];
}
