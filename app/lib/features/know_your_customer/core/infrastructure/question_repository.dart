import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/core/infrastructure/question_mapper.dart';
import 'package:fpdart/fpdart.dart';

class QuestionRepository {
  const QuestionRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, Question>> fetchQuestion({required final String id}) async {
    final response = await _client.get(Endpoints.question(id));

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération de la question'));
    }

    final fromJson = QuestionMapper.fromJson(response.data as Map<String, dynamic>);

    return fromJson == null ? Left(Exception('Erreur lors de la récupération de la question')) : Right(fromJson);
  }

  Future<Either<Exception, Unit>> update(final Question question) async {
    final data = switch (question) {
      QuestionMultiple() => question.responses.map((final e) => {'code': e.code, 'selected': e.isSelected}).toList(),
      QuestionUnique() => [
        {'value': question.response.value},
      ],
      QuestionMosaicBoolean() => question.responses.map((final e) => {'code': e.code, 'selected': e.isSelected}).toList(),
    };

    final response = await _client.put(Endpoints.question(question.code.value), data: data);

    if (isResponseSuccessful(response.statusCode)) {
      return const Right(unit);
    }

    return Left(Exception('Erreur lors de la mise à jour des réponses'));
  }
}
