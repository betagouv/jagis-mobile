import 'dart:async';

import 'package:app/features/services/core/bloc/service_event.dart';
import 'package:app/features/services/core/bloc/service_state.dart';
import 'package:app/features/services/core/infrastructure/service_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class ServiceBloc<T extends Object> extends Bloc<ServiceEvent<T>, ServiceState<T>> {
  ServiceBloc(this._serviceRepository, this._service, this._limit, this._fromJson) : super(const ServiceState.initial()) {
    on<ServiceLoadRequested<T>>(_serviceLoadRequested);
    on<ServiceCategoryChanged<T>>(_categoryChanged);
    on<ServiceAddressChanged<T>>(_addressChanged);
    on<ServiceSeeMore<T>>(_seeMore);
  }

  final ServiceRepository _serviceRepository;
  final String _service;
  final int _limit;
  final ServiceResult<T> _fromJson;

  Future<void> _serviceLoadRequested(final ServiceLoadRequested<T> event, final Emitter<ServiceState<T>> emit) async {
    emit(const ServiceState.loading());
    final categoriesResult = await _serviceRepository.fetchCategories(_service);
    if (categoriesResult.isLeft()) {
      emit(const ServiceState.failure());

      return;
    }

    final categories = categoriesResult.getRight().getOrElse(() => const ServiceCategories(elements: []));
    final defaultCategory = categories.elements.firstWhere((final category) => category.isDefault);
    final result = await _serviceRepository.fetch(
      service: _service,
      category: defaultCategory.code,
      limit: _limit,
      fromJson: _fromJson,
      address: state.address,
    );

    result.fold(
      (final exception) => emit(const ServiceState.failure()),
      (final suggestions) =>
          emit(ServiceState.success(categories: categories, categorySelected: defaultCategory, results: suggestions)),
    );
  }

  Future<void> _categoryChanged(final ServiceCategoryChanged<T> event, final Emitter<ServiceState<T>> emit) async {
    final result = await _serviceRepository.fetch(
      service: _service,
      category: event.category.code,
      limit: _limit,
      fromJson: _fromJson,
      address: state.address,
    );

    result.fold(
      (final exception) => emit(const ServiceState.failure()),
      (final results) => emit(state.copyWith(categorySelected: event.category, results: results)),
    );
  }

  Future<void> _addressChanged(final ServiceAddressChanged<T> event, final Emitter<ServiceState<T>> emit) async {
    final address = event.address;
    final result = await _serviceRepository.fetch(
      service: _service,
      category: state.categorySelected.code,
      limit: _limit,
      fromJson: _fromJson,
      address: address,
    );

    result.fold(
      (final exception) => emit(const ServiceState.failure()),
      (final results) => emit(state.copyWith(address: address, results: results)),
    );
  }

  Future<void> _seeMore(final ServiceSeeMore<T> event, final Emitter<ServiceState<T>> emit) async {
    final result = await _serviceRepository.fetch(
      service: _service,
      category: state.categorySelected.code,
      limit: state.results.numberResult + _limit,
      fromJson: _fromJson,
      address: state.address,
    );

    result.fold(
      (final exception) => emit(const ServiceState.failure()),
      (final results) => emit(state.copyWith(results: results)),
    );
  }
}
