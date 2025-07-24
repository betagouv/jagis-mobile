// ignore_for_file: prefer-null-aware-elements

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/recommandations/domain/recommendation.dart';
import 'package:app/features/recommandations/infrastructure/recommandation_mapper.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:fpdart/fpdart.dart';

class RecommandationsRepository {
  const RecommandationsRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, List<Recommendation>>> fetchByTheme({required final ThemeType? themeType}) async {
    final uri = Uri(
      path: Endpoints.recommendations,
      queryParameters: {if (themeType != null) 'thematique': themeType.name, 'nombre_max': '4', 'type': 'article'},
    );

    final response = await _client.get(uri.toString());

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des recommandations'));
    }

    final json = response.data as List<dynamic>;

    return Right(json.map((final e) => RecommandationMapper.fromJson(e as Map<String, dynamic>)).toList());
  }
}
