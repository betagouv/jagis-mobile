import 'package:app/core/address/address.dart';
import 'package:equatable/equatable.dart';

sealed class WinterRegistration extends Equatable {
  const WinterRegistration({required this.lastName});

  final String lastName;

  @override
  List<Object?> get props => [lastName];
}

final class WinterRegistrationByAddress extends WinterRegistration {
  const WinterRegistrationByAddress({required super.lastName, required this.address});

  final Address address;

  @override
  List<Object?> get props => [...super.props, address];
}

final class WinterRegistrationByPrm extends WinterRegistration {
  const WinterRegistrationByPrm({required super.lastName, required this.prmNumber});

  final String prmNumber;

  @override
  List<Object?> get props => [...super.props, prmNumber];
}
