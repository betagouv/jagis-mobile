import 'package:app/core/address/address.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum ServiceStatus { initial, loading, success, failure }

@immutable
final class ServiceState<T extends Object> extends Equatable {
  const ServiceState({
    required this.status,
    required this.categories,
    required this.categorySelected,
    required this.address,
    required this.suggestions,
  });

  const ServiceState.initial()
    : status = ServiceStatus.initial,
      categories = const ServiceCategories(elements: []),
      categorySelected = const ServiceCategory(code: '', label: '', isDefault: false),
      address = null,
      suggestions = const [];

  const ServiceState.loading()
    : status = ServiceStatus.loading,
      categories = const ServiceCategories(elements: []),
      categorySelected = const ServiceCategory(code: '', label: '', isDefault: false),
      address = null,
      suggestions = const [];

  const ServiceState.success({required this.categories, required this.categorySelected, required this.suggestions})
    : address = null,
      status = ServiceStatus.success;

  const ServiceState.failure()
    : status = ServiceStatus.failure,
      categories = const ServiceCategories(elements: []),
      categorySelected = const ServiceCategory(code: '', label: '', isDefault: false),
      address = null,
      suggestions = const [];

  final ServiceStatus status;
  final ServiceCategories categories;
  final ServiceCategory categorySelected;
  final Address? address;
  final List<T> suggestions;

  ServiceState<T> copyWith({
    final ServiceStatus? status,
    final ServiceCategories? categories,
    final ServiceCategory? categorySelected,
    final Address? address,
    final List<T>? suggestions,
  }) => ServiceState(
    status: status ?? this.status,
    categories: categories ?? this.categories,
    categorySelected: categorySelected ?? this.categorySelected,
    address: address ?? this.address,
    suggestions: suggestions ?? this.suggestions,
  );

  @override
  List<Object?> get props => [status, categories, categorySelected, address, suggestions];
}

class ServiceCategories extends Equatable {
  const ServiceCategories({required this.elements});

  final List<ServiceCategory> elements;

  @override
  List<Object> get props => [elements];
}

class ServiceCategory extends Equatable {
  const ServiceCategory({required this.code, required this.label, required this.isDefault});

  final String code;
  final String label;
  final bool isDefault;

  @override
  List<Object> get props => [code, label, isDefault];
}
