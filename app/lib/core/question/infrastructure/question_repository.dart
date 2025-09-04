import 'package:app/core/errors/failure.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/core/question/domain/question.dart';
import 'package:app/core/question/infrastructure/question_mapper.dart';
import 'package:fpdart/fpdart.dart';

class QuestionRepository {
  const QuestionRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Failure, Question>> fetchQuestion(final String questionCode) async {
    try {
      final question = Endpoints.question(questionCode);
      final response = await _client.get(question);

      if (isResponseUnsuccessful(response.statusCode)) {
        return const Left(ServerFailure('Erreur lors de la récupération de la question'));
      }

      return Right(QuestionMapper.fromJson(response.data as Map<String, dynamic>));
    } on Exception catch (exception) {
      return Left(UnexpectedFailure(exception.toString()));
    }
  }

  Future<Either<Failure, Unit>> update(final String questionCode, final Answers answers) async {
    try {
      final data = answers.toApiPayload();
      final response = await _client.put(Endpoints.question(questionCode), data: data);

      if (isResponseSuccessful(response.statusCode)) {
        return const Right(unit);
      }

      return const Left(ServerFailure('Erreur lors de la mise à jour des réponses'));
    } on Exception catch (exception) {
      return Left(UnexpectedFailure(exception.toString()));
    }
  }

  Future<Either<Failure, Unit>> skip(final Question question) async {
    try {
      final response = await _client.post(Endpoints.questionSkip(question.code));

      if (isResponseSuccessful(response.statusCode)) {
        return const Right(unit);
      }

      return const Left(ServerFailure('Erreur lors de la mise à jour des réponses'));
    } on Exception catch (exception) {
      return Left(UnexpectedFailure(exception.toString()));
    }
  }
}
