import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/quiz/domain/quiz.dart';
import 'package:app/features/quiz/infrastructure/quiz_mapper.dart';
import 'package:fpdart/fpdart.dart';

class QuizRepository {
  const QuizRepository({required final DioHttpClient client}) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, Quiz>> recupererQuiz(final String id) async {
    final response = await _client.get(Endpoints.quiz(id));

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération du quiz'));
    }

    final json = response.data as Map<String, dynamic>;

    return Right(QuizMapper.fromJson(json));
  }

  Future<Either<Exception, Unit>> submitResponse({required final String id, required final bool isCorrect}) async {
    final response = await _client.patch(Endpoints.quiz(id), data: {'pourcent': isCorrect ? 100 : 0});

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : Left(Exception('Erreur lors de la validation du quiz'));
  }
}
