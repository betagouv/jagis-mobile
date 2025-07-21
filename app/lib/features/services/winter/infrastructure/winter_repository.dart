import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/services/winter/domain/winter_my_consumption_data.dart';
import 'package:app/features/services/winter/domain/winter_registration.dart';
import 'package:fpdart/fpdart.dart';

class WinterRepository {
  const WinterRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, Unit>> register(final WinterRegistration registration) => switch (registration.type) {
    RegistrationType.address => _registerByAddress(registration),
    RegistrationType.prm => _registerByPrm(registration),
  };

  Future<Either<Exception, Unit>> _registerByAddress(final WinterRegistration registration) async {
    final address = registration.address!;
    final response = await _client.post(
      Endpoints.winterInscriptionParAdresse,
      data: {
        'nom': registration.lastName,
        'adresse': '${address.houseNumber ?? ''} ${address.street ?? ''}',
        'code_postal': address.postCode,
        'code_commune': address.cityCode,
      },
    );

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception("Erreur lors de l'inscription par adresse"));
    }

    return const Right(unit);
  }

  Future<Either<Exception, Unit>> _registerByPrm(final WinterRegistration registration) async {
    final response = await _client.post(
      Endpoints.winterInscriptionParPrm,
      data: {'nom': registration.lastName, 'prm': registration.prmNumber!},
    );

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception("Erreur lors de l'inscription par PRM"));
    }

    return const Right(unit);
  }

  Future<Either<Exception, WinterMyConsumptionData>> getConsumption() async {
    final response = await _client.get(Endpoints.winterConsumption);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération de la consommation'));
    }

    final body = response.data as Map<String, dynamic>;

    return Right(WinterMyConsumptionData.fromJson(body));
  }

  Future<Either<Exception, int>> getNumberOfActions() async {
    final response = await _client.get(Endpoints.winterActions);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération du nombre d’actions'));
    }

    final body = response.data as Map<String, dynamic>;
    final actions = body['actions'] as List<dynamic>;

    return Right(actions.length);
  }

  Future<List<ActionSummary>> getActions() async {
    final response = await _client.get(Endpoints.winterActions);

    if (isResponseUnsuccessful(response.statusCode)) {
      throw Exception('Erreur lors de la récupération de la consommation');
    }

    final body = response.data as Map<String, dynamic>;
    final actions = body['actions'] as List<dynamic>;

    return ActionSummary.fromJsonList(actions);
  }
}
