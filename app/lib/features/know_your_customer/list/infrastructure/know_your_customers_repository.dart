import 'package:app/core/helpers/json_mapper.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/core/question/domain/question.dart';
import 'package:app/core/question/infrastructure/question_mapper.dart';
import 'package:fpdart/fpdart.dart';

class KnowYourCustomersRepository {
  const KnowYourCustomersRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, List<Question>>> fetchQuestions() async {
    final response = await _client.get(Endpoints.questionsKyc);
    if (isResponseSuccessful(response.statusCode)) {
      return Right(JsonHelpers.fromJsonList(response.data, QuestionMapper.fromJson).filter((final e) => e.isAnswered).toList());
    }

    return Left(Exception('Erreur lors de la récupération des questions'));
  }
}
