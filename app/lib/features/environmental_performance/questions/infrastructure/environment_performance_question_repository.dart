import 'package:app/core/helpers/json_mapper.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/core/question/domain/question.dart';
import 'package:app/core/question/infrastructure/question_mapper.dart';
import 'package:fpdart/fpdart.dart';

class EnvironmentalPerformanceQuestionRepository {
  const EnvironmentalPerformanceQuestionRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, List<Question>>> fetchBilanByCategory(final String categoryId) async {
    final response = await _client.get(Endpoints.questions(categoryId));
    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération les questions du bilan'));
    }

    return Right(JsonHelpers.fromJsonList(response.data, QuestionMapper.fromJson));
  }
}
