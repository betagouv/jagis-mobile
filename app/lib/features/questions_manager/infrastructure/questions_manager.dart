import 'package:app/core/helpers/json_mapper.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/core/infrastructure/question_mapper.dart';
import 'package:app/features/questions_manager/domain/cursor_manager_from_list.dart';

class QuestionsManager extends CursorManagerFromList<Question> {
  QuestionsManager({required final DioHttpClient client, required final ActionType type, required final String code})
    : super(
        getList: () async {
          final response = await client.get(Endpoints.action(type: actionTypeToAPIString(type), code: code));

          final data = response.data as Map<String, dynamic>;

          return JsonListMapper.fromJsonList(data['kycs'], QuestionMapper.fromJson);
        },
      );
}
