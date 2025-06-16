import 'package:app/core/address/address.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class AddressFetchRequested extends AddressEvent {
  const AddressFetchRequested();
}

@immutable
final class AddressSelected extends AddressEvent {
  const AddressSelected(this.address);

  final Address address;

  @override
  List<Object> get props => [address];
}

@immutable
final class AddressSaveRequested extends AddressEvent {
  const AddressSaveRequested();
}
