import 'dart:async';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/theme_hub/domain/theme_hub_model.dart';
import 'package:app/features/theme_hub/infrastructure/theme_hub_mapper.dart';
import 'package:fpdart/fpdart.dart';

class ThemeHubRepository {
  const ThemeHubRepository({required final DioHttpClient client}) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, ThemeHubModel>> fetch() async {
    final response = await _client.get(Endpoints.themes);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des données'));
    }

    final json = response.data! as Map<String, dynamic>;

    return Right(ThemeHubMapper.fromJson(json));
  }
}
