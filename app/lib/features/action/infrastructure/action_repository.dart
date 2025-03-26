import 'dart:async';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/infrastructure/action_mapper.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:fpdart/fpdart.dart';

class ActionRepository {
  const ActionRepository(this._client, this._messageBus);

  final DioHttpClient _client;
  final MessageBus _messageBus;

  Future<Either<Exception, Action>> fetch({required final ActionType type, required final String id}) async {
    final actionTypeAPI = actionTypeToAPIString(type);
    final response = await _client.get(Endpoints.action(type: actionTypeAPI, code: id));

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception("Type: $actionTypeAPI,\nID: $id,\nError: Erreur lors de la récupération de l'action: $response"));
    }

    final json = response.data! as Map<String, dynamic>;

    final value = switch (type) {
      ActionType.simulator => ActionSimulatorMapper.fromJson(json),
      ActionType.classic => ActionClassicMapper.fromJson(json),
      ActionType.quiz => ActionQuizMapper.fromJson(json),
      ActionType.performance => ActionPerformanceMapper.fromJson(json),
    };

    return Right(value);
  }

  Future<Either<Exception, Unit>> markAsDone({required final ActionType type, required final String id}) async {
    await _client.post(Endpoints.actionFaite(type: actionTypeToAPIString(type), code: id));

    _messageBus.publish(actionDoneTopic);

    return const Right(unit);
  }
}
