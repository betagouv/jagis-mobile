import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/question_flow/domain/current_question.dart';
import 'package:app/core/question_flow/domain/cursor.dart';
import 'package:app/core/question_flow/domain/cursor_manager.dart';
import 'package:app/core/question_flow/infrastructure/current_question_mapper.dart';
import 'package:fpdart/fpdart.dart';

class QuestionFlowManager implements CursorManager<CurrentQuestion> {
  const QuestionFlowManager(this._client, {required this.sequenceId});

  final String sequenceId;
  final DioHttpClient _client;

  @override
  Future<Cursor<CurrentQuestion>> first() async {
    final path = Endpoints.questionsFirst(sequenceId);
    final response = await _client.get(path);
    final element = CurrentQuestionMapper.fromJson(response.data as Map<String, dynamic>);

    return Cursor(element: element, index: element.currentPosition, total: element.totalNumberOfQuestions);
  }

  @override
  Future<Cursor<CurrentQuestion>> previous(final Cursor<CurrentQuestion> current) async {
    final response = await _client.get(Endpoints.questionsPrevious(sequenceId, current.element.question.code.value));
    final element = CurrentQuestionMapper.fromJson(response.data as Map<String, dynamic>);

    return Cursor(element: element, index: element.currentPosition, total: element.totalNumberOfQuestions);
  }

  @override
  Future<Either<Unit, Cursor<CurrentQuestion>>> next(final Cursor<CurrentQuestion> current) async {
    final response = await _client.get(Endpoints.questionsNext(sequenceId, current.element.question.code.value));
    final data = response.data as Map<String, dynamic>;

    if (!data.containsKey('question_courante')) {
      return const Left(unit);
    }

    final element = CurrentQuestionMapper.fromJson(data);

    return Right(Cursor(element: element, index: element.currentPosition, total: element.totalNumberOfQuestions));
  }
}
