import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/core/infrastructure/question_mapper.dart';
import 'package:fpdart/fpdart.dart';

class EnvironmentalPerformanceQuestionRepository {
  const EnvironmentalPerformanceQuestionRepository({required final DioHttpClient client}) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, List<Question>>> fetchBilanByCategory(final String categoryId) async {
    final response = await _client.get(Endpoints.questions(categoryId));
    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération les questions du bilan'));
    }

    final data = response.data! as List<dynamic>;

    return Right(data.cast<Map<String, dynamic>>().map(QuestionMapper.fromJson).whereType<Question>().toList());
  }
}
