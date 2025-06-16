import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:fpdart/fpdart.dart';

class WinterRepository {
  const WinterRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, Unit>> verify(final String address, final String lastName) async {
    final response = await _client.post(Endpoints.winterVerify, data: {'adresse': address, 'nom': lastName});

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la vérification'));
    }

    return const Right(unit);
  }
}
