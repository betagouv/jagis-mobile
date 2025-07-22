import 'package:equatable/equatable.dart';

enum RegistrationType { address, prm }

class WinterRegistration extends Equatable {
  const WinterRegistration({required this.type, required this.lastName, this.prmNumber});

  final RegistrationType type;
  final String lastName;
  final String? prmNumber;

  @override
  List<Object?> get props => [type, lastName, prmNumber];
}
