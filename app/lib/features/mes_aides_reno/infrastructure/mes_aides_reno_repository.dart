import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/mes_aides_reno/domain/mes_aides_reno_data.dart';
import 'package:app/features/mes_aides_reno/infrastructure/mes_aides_reno_mapper.dart';
import 'package:fpdart/fpdart.dart';

class MesAidesRenoRepository {
  const MesAidesRenoRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, MesAidesRenoData>> getUrls() async {
    final response = await _client.get(Endpoints.mesAidesRenoGetIframes);

    final json = response.data! as Map<String, dynamic>;

    return isResponseUnsuccessful(response.statusCode)
        ? Left(Exception('Erreur lors de la récupération de Mes Aides Réno'))
        : Right(MesAidesRenoDataMapper.fromJson(json));
  }

  Future<Either<Exception, Unit>> sendSituation(final Map<String, dynamic> situation) async {
    final response = await _client.post(Endpoints.mesAidesRenoPostSituation, data: situation);

    return isResponseUnsuccessful(response.statusCode)
        ? Left(Exception("Erreur lors de l'envoi de la situation"))
        : const Right(unit);
  }
}
