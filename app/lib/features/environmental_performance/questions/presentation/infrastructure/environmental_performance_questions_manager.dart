import 'package:app/core/helpers/json_mapper.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/core/infrastructure/question_mapper.dart';
import 'package:app/features/questions_manager/domain/cursor_manager_from_list.dart';

class EnvironmentalPerformanceQuestionsManager extends CursorManagerFromList<Question> {
  EnvironmentalPerformanceQuestionsManager({required final DioHttpClient client, required final String categoryId})
    : super(
        getList: () async {
          final response = await client.get(Endpoints.questions(categoryId));

          if (isResponseUnsuccessful(response.statusCode)) {
            // FIXME(erolley): how should we handle this error?
            return [];
          }

          return JsonListMapper.fromJsonList(response.data, QuestionMapper.fromJson);
        },
      );
}
