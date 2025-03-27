import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/recommandations/infrastructure/recommandation_mapper.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:fpdart/fpdart.dart';

class RecommandationsRepository {
  const RecommandationsRepository({required final DioHttpClient client}) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, List<Recommandation>>> recuperer(final ThemeType thematique) async {
    final response = await _client.get(Endpoints.recommandationsParThematique(thematique.name));

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des recommandations'));
    }

    final json = response.data as List<dynamic>;

    return Right(json.map((final e) => RecommandationMapper.fromJson(e as Map<String, dynamic>)).toList());
  }

  Future<Either<Exception, List<Recommandation>>> recupererV3({final int? maxItem, final TypeDuContenu? type}) async {
    final parameters = <String, String>{
      if (maxItem != null) 'max_item': maxItem.toString(),
      if (type != null) 'type': RecommandationMapper.mapContentTypeToJson(type),
    };
    final uri = Uri(path: Endpoints.recommandationsV3, queryParameters: parameters.isNotEmpty ? parameters : null);
    final response = await _client.get(uri.toString());

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des recommandations'));
    }

    final json = response.data as List<dynamic>;

    return Right(json.map((final e) => RecommandationMapper.fromJson(e as Map<String, dynamic>)).toList());
  }
}
