import 'package:app/core/address/address.dart';
import 'package:app/features/services/core/bloc/service_state.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ServiceEvent<T extends Object> extends Equatable {
  const ServiceEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ServiceLoadRequested<T extends Object> extends ServiceEvent<T> {
  const ServiceLoadRequested();
}

@immutable
final class ServiceCategoryChanged<T extends Object> extends ServiceEvent<T> {
  const ServiceCategoryChanged({required this.category});

  final ServiceCategory category;
  @override
  List<Object> get props => [category];
}

@immutable
final class ServiceAddressChanged<T extends Object> extends ServiceEvent<T> {
  const ServiceAddressChanged({required this.address});

  final Address address;
  @override
  List<Object> get props => [address];
}
