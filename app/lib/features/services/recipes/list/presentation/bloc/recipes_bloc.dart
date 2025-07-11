import 'dart:async';

import 'package:app/features/services/recipes/list/infrastructure/recipes_repository.dart';
import 'package:app/features/services/recipes/list/presentation/bloc/recipes_event.dart';
import 'package:app/features/services/recipes/list/presentation/bloc/recipes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  RecipesBloc(this._repository) : super(const RecipesInitial()) {
    on<RecipesLoadRequested>(_onLoadRequested);
    on<RecipesFilterSelected>(_onFilterSelected);
    on<RecipesSeeMore>(_onSeeMore);
  }

  final RecipesRepository _repository;

  Future<void> _onLoadRequested(final RecipesLoadRequested event, final Emitter<RecipesState> emit) async {
    emit(const RecipesLoadInProgress());
    final categoriesResult = await _repository.fetchCategories();
    if (categoriesResult.isRight()) {
      final categories = categoriesResult.getRight().getOrElse(() => throw Exception());
      final filterSelected = categories.firstWhere((final e) => e.value).code;
      final result = await _repository.fetchRecipe(category: filterSelected, limit: 9);
      result.fold(
        (final l) => emit(RecipesLoadFailure(errorMessage: l.toString())),
        (final r) => emit(RecipesLoadSuccess(filters: categories, filterSelected: filterSelected, recipes: r)),
      );
    } else {
      emit(RecipesLoadFailure(errorMessage: categoriesResult.getLeft().toString()));
    }
  }

  Future<void> _onFilterSelected(final RecipesFilterSelected event, final Emitter<RecipesState> emit) async {
    final filterSelected = event.value;
    final result = await _repository.fetchRecipe(category: filterSelected, limit: 9);

    result.fold(
      (final l) => emit(RecipesLoadFailure(errorMessage: l.toString())),
      (final r) => emit(
        RecipesLoadSuccess(
          filters: switch (state) {
            final RecipesLoadSuccess s => s.filters,
            _ => const [],
          },
          filterSelected: filterSelected,
          recipes: r,
        ),
      ),
    );
  }

  Future<void> _onSeeMore(final RecipesSeeMore event, final Emitter<RecipesState> emit) async {
    final current = state;
    if (current is RecipesLoadSuccess) {
      final filterSelected = current.filterSelected;
      final result = await _repository.fetchRecipe(category: filterSelected, limit: current.recipes.numberResult + 9);
      result.fold(
        (final error) => emit(RecipesLoadFailure(errorMessage: error.toString())),
        (final recipes) => emit(current.copyWith(recipes: recipes)),
      );
    }
  }
}
