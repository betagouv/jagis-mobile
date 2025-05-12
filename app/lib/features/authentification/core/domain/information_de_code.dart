import 'package:equatable/equatable.dart';

class InformationDeCode extends Equatable {
  const InformationDeCode({required this.email, required this.code});

  final String email;
  final String code;

  @override
  List<Object?> get props => [email, code];
}
