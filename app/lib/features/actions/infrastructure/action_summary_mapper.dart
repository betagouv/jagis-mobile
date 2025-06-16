import 'package:app/features/action/domain/action.dart';
import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/actions/domain/action_type.dart';

abstract final class ActionSummaryMapper {
  const ActionSummaryMapper._();

  static ActionSummary _fromJson(final Map<String, dynamic> json) => ActionSummary(
    type: actionTypeFromAPIString(json['type'] as String),
    id: json['code'] as String,
    title: json['titre'] as String,
    numberOfAidsAvailable: json['nombre_aides_disponibles'] as int,
  );

  static List<ActionSummary> fromJsonList(final List<dynamic> jsonList) => jsonList
      .cast<Map<String, dynamic>>()
      .map(_fromJson)
      .where((final e) => e.type != ActionType.simulator || ActionSimulatorId.isSimulatorId(e.id))
      .toList();
}
