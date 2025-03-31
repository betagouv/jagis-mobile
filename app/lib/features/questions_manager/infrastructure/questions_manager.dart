import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/core/infrastructure/question_mapper.dart';
import 'package:app/features/questions_manager/domain/cursor_manager_from_list.dart';

// FIXME(lsaudon): on peut faire générique avec CarSimulatorQuestionsManager
class QuestionsManager extends CursorManagerFromList<Question> {
  QuestionsManager({required final DioHttpClient client, required final ActionType type, required final String code})
    : super(
        getList: () async {
          final response = await client.get(Endpoints.action(type: actionTypeToAPIString(type), code: code));

          return ((response.data as Map<String, dynamic>)['kycs'] as List<dynamic>)
              .cast<Map<String, dynamic>>()
              .map(QuestionMapper.fromJson)
              .toList();
        },
      );
}
