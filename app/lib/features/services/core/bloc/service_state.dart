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
    required this.results,
  });

  const ServiceState.initial()
    : status = ServiceStatus.initial,
      categories = const ServiceCategories(elements: []),
      categorySelected = const ServiceCategory(code: '', label: '', isDefault: false),
      address = null,
      results = const ServiceResults(moreResultsAvailable: false, numberResult: 0, suggestions: []);

  const ServiceState.loading()
    : status = ServiceStatus.loading,
      categories = const ServiceCategories(elements: []),
      categorySelected = const ServiceCategory(code: '', label: '', isDefault: false),
      address = null,
      results = const ServiceResults(moreResultsAvailable: false, numberResult: 0, suggestions: []);

  const ServiceState.success({required this.categories, required this.categorySelected, required this.results})
    : address = null,
      status = ServiceStatus.success;

  const ServiceState.failure()
    : status = ServiceStatus.failure,
      categories = const ServiceCategories(elements: []),
      categorySelected = const ServiceCategory(code: '', label: '', isDefault: false),
      address = null,
      results = const ServiceResults(moreResultsAvailable: false, numberResult: 0, suggestions: []);

  final ServiceStatus status;
  final ServiceCategories categories;
  final ServiceCategory categorySelected;
  final Address? address;
  final ServiceResults<T> results;

  ServiceState<T> copyWith({
    final ServiceStatus? status,
    final ServiceCategories? categories,
    final ServiceCategory? categorySelected,
    final Address? address,
    final ServiceResults<T>? results,
  }) => ServiceState(
    status: status ?? this.status,
    categories: categories ?? this.categories,
    categorySelected: categorySelected ?? this.categorySelected,
    address: address ?? this.address,
    results: results ?? this.results,
  );

  @override
  List<Object?> get props => [status, categories, categorySelected, address, results];
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

class ServiceResults<T extends Object> extends Equatable {
  const ServiceResults({required this.moreResultsAvailable, required this.numberResult, required this.suggestions});

  final bool moreResultsAvailable;
  final int numberResult;
  final List<T> suggestions;

  @override
  List<Object?> get props => [moreResultsAvailable, numberResult, suggestions];
}
