import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/home/domain/home_dashboard.dart';
import 'package:fpdart/fpdart.dart';

class HomeDashboardRepository {
  const HomeDashboardRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, HomeDashboard>> fetch() async {
    final response = await _client.get(Endpoints.homeBoard);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération du tableau de bord'));
    }

    final json = response.data as Map<String, dynamic>;

    return Right(HomeDashboard.fromJson(json));
  }
}
