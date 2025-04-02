import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:fpdart/fpdart.dart';

class QuizRepository {
  const QuizRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, Unit>> submitResponse({required final String id, required final bool isCorrect}) async {
    final response = await _client.patch(Endpoints.quiz(id), data: {'pourcent': isCorrect ? 100 : 0});

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : Left(Exception('Erreur lors de la validation du quiz'));
  }
}
