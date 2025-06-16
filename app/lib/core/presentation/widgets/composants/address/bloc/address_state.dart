import 'package:app/core/address/address.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum AddressStatus { initial, loaded }

@immutable
final class AddressState extends Equatable {
  const AddressState(this.status, this.address, this.selectedAddress);

  final AddressStatus status;
  final Address? address;
  final Address? selectedAddress;
  bool get isAddressModified => address != selectedAddress;

  @override
  List<Object?> get props => [status, address, selectedAddress];
}
