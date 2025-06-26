import 'dart:async';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/actions/domain/action_catalog.dart';
import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/actions/infrastructure/action_catalog_mapper.dart';
import 'package:fpdart/fpdart.dart';

class ActionsRepository {
  const ActionsRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, ActionCatalog>> fetch({
    final List<String> themes = const [],
    final String title = '',
    final bool alreadyConsulted = false,
    final bool areDone = false,
  }) async {
    final queryParameters = <String, dynamic>{
      if (title.isNotEmpty) 'titre': title,
      if (themes.isNotEmpty) 'thematique': themes,
      if (alreadyConsulted) 'consultation': 'vu',
      if (areDone) 'realisation': 'faite',
    };

    final url = Uri(path: Endpoints.actions, queryParameters: queryParameters.isEmpty ? null : queryParameters).toString();
    final response = await _client.get(url);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des actions'));
    }

    final json = response.data! as Map<String, dynamic>;

    return Right(ActionCatalogMapper.fromJson(json));
  }

  Future<Either<Exception, List<ActionSummary>>> fetchForHome({required final bool areRecommendedActions}) async {
    final queryParameters = <String, dynamic>{
      'realisation': areRecommendedActions ? 'pas_faite' : 'faite',
      'ordre': 'recommandee_filtre_perso',
      'take': '6',
    };

    final url = Uri(path: Endpoints.actions, queryParameters: queryParameters).toString();
    final response = await _client.get(url);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des actions'));
    }

    final json = response.data! as Map<String, dynamic>;

    return Right(ActionSummary.fromJsonList(json['actions'] as List<dynamic>));
  }
}
