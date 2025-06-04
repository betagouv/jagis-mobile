import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/ranking/domain/ranking.dart';
import 'package:app/features/ranking/infrastructure/ranking_dto.dart';
import 'package:fpdart/fpdart.dart';

class RankingRepository {
  const RankingRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, Ranking>> fetchLocalRanking() async {
    final response = await _client.get(Endpoints.localRanking);

    return isResponseUnsuccessful(response.statusCode)
        ? Left(Exception('Erreur lors de la récupération du classement local'))
        : Right(RankingDto.fromJson(response.data as Map<String, dynamic>));
  }

  Future<Either<Exception, Ranking>> fetchNationalRanking() async {
    final response = await _client.get(Endpoints.nationalRanking);

    return isResponseUnsuccessful(response.statusCode)
        ? Left(Exception('Erreur lors de la récupération du classement national'))
        : Right(RankingDto.fromJson(response.data as Map<String, dynamic>));
  }
}
