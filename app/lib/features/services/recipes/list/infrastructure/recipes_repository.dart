import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/services/core/bloc/service_state.dart';
import 'package:app/features/services/recipes/list/domain/recipe_filter.dart';
import 'package:app/features/services/recipes/list/domain/recipe_summary.dart';
import 'package:app/features/services/recipes/list/infrastructure/plant_month_mapper.dart';
import 'package:app/features/services/recipes/list/infrastructure/recipe_summary_mapper.dart';
import 'package:fpdart/fpdart.dart';

class RecipesRepository {
  const RecipesRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, List<RecipeFilter>>> fetchCategories() async {
    final response = await _client.get(Endpoints.recipesCategories);

    return isResponseUnsuccessful(response.statusCode)
        ? Left(Exception('Erreur lors de la récupération les mois des fruits et légumes'))
        : Right((response.data as List<dynamic>).cast<Map<String, dynamic>>().map(RecipeFilterMapper.fromJson).toList());
  }

  Future<Either<Exception, ServiceResults<RecipeSummary>>> fetchRecipe({
    required final String category,
    required final int limit,
  }) async {
    final response = await _client.post(
      Endpoints.recipesSearch,
      data: {'categorie': category, 'nombre_max_resultats': limit, 'rayon_metres': 5000},
    );

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des recettes'));
    }

    final responseData = response.data as Map<String, dynamic>;

    final list = (responseData['resultats'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(RecipeSummaryMapper.fromJson)
        .toList();

    return Right(
      ServiceResults(
        moreResultsAvailable: responseData['encore_plus_resultats_dispo'] as bool,
        numberResult: limit,
        suggestions: list,
      ),
    );
  }
}
