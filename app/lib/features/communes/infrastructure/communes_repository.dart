import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/communes/municipality.dart';

class CommunesRepository {
  const CommunesRepository(this._client);

  final DioHttpClient _client;

  Future<List<Municipality>> fetchMunicipalities(final String postalCode) async {
    final response = await _client.get(Endpoints.communes(postalCode));

    if (isResponseUnsuccessful(response.statusCode)) {
      return throw Exception('Erreur lors de la récupération des communes');
    }

    final rawList = response.data as List<dynamic>;

    return rawList.cast<Map<String, dynamic>>().map(Municipality.fromJson).toList(growable: false);
  }
}
