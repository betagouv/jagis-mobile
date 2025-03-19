import 'dart:async';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/infrastructure/action_mapper.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:fpdart/fpdart.dart';

class ActionRepository {
  const ActionRepository({required final DioHttpClient client}) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, Action>> fetch({required final ActionType type, required final String id}) async {
    final actionTypeAPI = actionTypeToAPIString(type);
    final response = await _client.get(Endpoints.action(type: actionTypeAPI, code: id));

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception("Type: $actionTypeAPI,\nID: $id,\nError: Erreur lors de la récupération de l'action: $response"));
    }

    final json = response.data! as Map<String, dynamic>;

    return switch (type) {
      ActionType.simulator => Right(ActionSimulatorMapper.fromJson(json)),
      ActionType.classic => Right(ActionClassicMapper.fromJson(json)),
      ActionType.quiz => Right(ActionQuizMapper.fromJson(json)),
      ActionType.performance =>
        // TODO(erolley): Handle this case.
        throw UnimplementedError(),
    };
  }

  Future<void> markAsDone({required final ActionType type, required final String id}) async {
    final actionTypeAPI = actionTypeToAPIString(type);
    // TODO(erolley): we may want to handle the response here.
    await _client.post(Endpoints.actionFaite(type: actionTypeAPI, code: id));
  }
}
