import 'package:app/core/helpers/json_mapper.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/services/maif/domain/maif.dart';
import 'package:app/features/services/maif/domain/maif_risk.dart';
import 'package:app/features/services/maif/infrastructure/maif_commune_data_mapper.dart';
import 'package:app/features/services/maif/infrastructure/maif_risk_mapper.dart';
import 'package:fpdart/fpdart.dart';

class MaifRepository {
  const MaifRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, MaifCommuneData>> fetch() async {
    final response = await _client.get(Endpoints.logement);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des données'));
    }

    final json = response.data as Map<String, dynamic>;

    return Right(MaifCommuneDataMapper.fromJson(json));
  }

  Future<Either<Exception, List<MaifRisk>>> fetchScore(final double latitude, final double longitude) async {
    final response = await _client.post(
      Endpoints.maifSearch,
      data: {'categorie': 'score_risque', 'latitude': latitude, 'longitude': longitude},
    );

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des données'));
    }

    final json = response.data as Map<String, dynamic>;

    return Right(JsonHelpers.fromJsonList(json['resultats'], MaifRiskMapper.fromJson));
  }

  Future<Either<Exception, int>> fetchCatNat(final String cityCode) async {
    final response = await _client.post(Endpoints.maifSearch, data: {'categorie': 'catnat', 'code_commune': cityCode});

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des informations'));
    }

    return Right(((response.data as Map<String, dynamic>)['resultats'] as List<dynamic>).length);
  }

  Future<Either<Exception, int>> fetchDroughtPercentage(final String cityCode) async {
    final response = await _client.post(Endpoints.maifSearch, data: {'categorie': 'zones_secheresse', 'code_commune': cityCode});

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des informations'));
    }

    return Right(
      (((response.data as Map<String, dynamic>)['resultats'] as List<dynamic>).cast<Map<String, dynamic>>().firstWhere(
                (final element) => element['id'] == 'zone_total',
              )['pourcentage']
              as num)
          .toInt(),
    );
  }

  Future<Either<Exception, int>> fetchFloodPercentage(final String cityCode) async {
    final response = await _client.post(Endpoints.maifSearch, data: {'categorie': 'zones_inondation', 'code_commune': cityCode});

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des informations'));
    }

    return Right(
      (((response.data as Map<String, dynamic>)['resultats'] as List<dynamic>).cast<Map<String, dynamic>>().firstWhere(
                (final element) => element['id'] == 'zone_total',
              )['pourcentage']
              as num)
          .toInt(),
    );
  }
}
