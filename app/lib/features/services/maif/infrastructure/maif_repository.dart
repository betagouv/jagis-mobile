import 'package:app/core/helpers/json_mapper.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/services/maif/domain/maif_city_risk.dart';
import 'package:app/features/services/maif/domain/maif_risk.dart';
import 'package:app/features/services/maif/infrastructure/maif_risk_mapper.dart';
import 'package:fpdart/fpdart.dart';

class MaifRepository {
  const MaifRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, MaifCityRisk>> fetchCityRisk(final String cityCode) async {
    final response = await _client.get(
      Uri.parse(Endpoints.riskCity).replace(queryParameters: {'code_commune': cityCode}).toString(),
    );

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des données'));
    }

    final json = response.data as Map<String, dynamic>;

    return Right(MaifCityRisk.fromJson(json));
  }

  Future<Either<Exception, List<MaifRisk>>> fetchStreetRisks(final double latitude, final double longitude) async {
    final response = await _client.get(
      Uri.parse(
        Endpoints.riskStreet,
      ).replace(queryParameters: {'latitude': latitude.toString(), 'longitude': longitude.toString()}).toString(),
    );

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des données'));
    }

    return Right(JsonHelpers.fromJsonList(response.data, MaifRiskMapper.fromJson));
  }
}
