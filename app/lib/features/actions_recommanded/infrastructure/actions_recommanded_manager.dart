import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/core/infrastructure/question_mapper.dart';
import 'package:app/features/questions_manager/domain/cursor_manager_from_list.dart';

class ActionsRecommandedQuestionsManager extends CursorManagerFromList<Question> {
  ActionsRecommandedQuestionsManager({required final DioHttpClient client, required final String sequenceId})
    : super(
        getList: () async {
          final response = await client.get(Endpoints.questions(sequenceId));
          final data = response.data as List<dynamic>;

          return data.cast<Map<String, dynamic>>().map(QuestionMapper.fromJson).whereType<Question>().toList();
        },
      );
}
