import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/core/infrastructure/question_mapper.dart';
import 'package:app/features/questions_manager/domain/cursor_manager_from_list.dart';

class CarSimulatorQuestionsManager extends CursorManagerFromList<Question> {
  CarSimulatorQuestionsManager({required final DioHttpClient client})
    : super(
        getList: () async {
          final response = await client.get(
            Endpoints.action(type: actionTypeToAPIString(ActionType.simulator), code: ActionSimulatorId.carSimulator.apiString),
          );

          final data = response.data as Map<String, dynamic>;

          return (data['kycs'] as List<dynamic>)
              .cast<Map<String, dynamic>>()
              .map(QuestionMapper.fromJson)
              .whereType<Question>()
              .toList();
        },
      );
}
