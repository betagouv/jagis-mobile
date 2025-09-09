import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:equatable/equatable.dart';

class CommunesRepository {
  const CommunesRepository(this._client);

  final DioHttpClient _client;

  Future<List<Commune>> recupererLesCommunes(final String codePostal) async {
    final response = await _client.get(Endpoints.communes(codePostal));

    if (isResponseUnsuccessful(response.statusCode)) {
      return throw Exception('Erreur lors de la récupération des communes');
    }

    return (response.data as List<dynamic>).cast<Map<String, dynamic>>().map(Commune.fromJson).toList();
  }
}

class Commune extends Equatable {
  Commune.fromJson(final Map<String, dynamic> json) : code = json['code'] as String, label = json['label'] as String;

  final String code;

  final String label;

  @override
  List<Object?> get props => [code, label];
}
