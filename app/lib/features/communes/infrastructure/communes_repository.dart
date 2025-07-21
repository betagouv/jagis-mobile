import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';

class CommunesRepository {
  const CommunesRepository(this._client);

  final DioHttpClient _client;

  Future<List<String>> recupererLesCommunes(final String codePostal) async {
    final response = await _client.get(Endpoints.communes(codePostal));

    if (isResponseUnsuccessful(response.statusCode)) {
      return throw Exception('Erreur lors de la récupération des communes');
    }

    return (response.data as List<dynamic>).cast();
  }
}
