import 'package:app/core/address/address.dart';
import 'package:equatable/equatable.dart';

enum RegistrationType { address, prm }

class WinterRegistration extends Equatable {
  const WinterRegistration({required this.type, required this.lastName, this.address, this.prmNumber});

  final RegistrationType type;
  final String lastName;
  final Address? address;
  final String? prmNumber;

  @override
  List<Object?> get props => [type, lastName, address, prmNumber];
}
