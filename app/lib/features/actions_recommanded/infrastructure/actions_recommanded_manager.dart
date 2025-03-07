import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/core/infrastructure/question_mapper.dart';
import 'package:app/features/questions_manager/domain/cursor.dart';
import 'package:app/features/questions_manager/domain/cursor_manager.dart';

// TODO(erolley): This could be abstracted to be used for all list based manager.
class ActionsRecommandedQuestionsManager extends CursorManager<Question> {
  const ActionsRecommandedQuestionsManager({required final DioHttpClient client, required final String sequenceId})
    : _client = client,
      _sequenceId = sequenceId;

  final DioHttpClient _client;
  final String _sequenceId;

  @override
  Future<Cursor<Question>> first() async {
    final list = await _getList();

    return list.isEmpty
        ? const Cursor(element: null, index: 0, total: 0)
        : Cursor(element: list.first, index: 0, total: list.length);
  }

  @override
  Future<Cursor<Question>> previous(final Cursor<Question> current) async {
    final list = await _getList();
    final previousIndex = current.index - 1;

    return previousIndex < 0
        ? Cursor(element: list.first, index: 0, total: list.length)
        : Cursor(element: list[previousIndex], index: previousIndex, total: list.length);
  }

  @override
  Future<Cursor<Question>> next(final Cursor<Question> current) async {
    final list = await _getList();
    final nextIndex = current.index + 1;

    return nextIndex >= list.length
        ? Cursor(element: null, index: current.index, total: list.length)
        : Cursor(element: list[nextIndex], index: nextIndex, total: list.length);
  }

  Future<List<Question>> _getList() async {
    final url = Endpoints.questions(_sequenceId);
    final response = await _client.get(url);
    final data = response.data as List<dynamic>;

    return data.cast<Map<String, dynamic>>().map(QuestionMapper.fromJson).whereType<Question>().toList();
  }
}
