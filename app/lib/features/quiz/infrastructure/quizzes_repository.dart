import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/quiz/domain/quiz_score.dart';
import 'package:fpdart/fpdart.dart';

class QuizzesRepository {
  const QuizzesRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, QuizScore>> score({required final String id}) async {
    final response = await _client.get(Endpoints.quizScore(id));

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la validation du quiz'));
    }

    final json = response.data! as Map<String, dynamic>;

    return Right(QuizScore.fromJson(json));
  }
}
