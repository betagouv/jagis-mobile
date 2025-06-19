import 'package:app/features/action/domain/action.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:equatable/equatable.dart';

final class ActionSummary extends Equatable {
  ActionSummary._fromJson(final Map<String, dynamic> json)
    : type = actionTypeFromAPIString(json['type'] as String),
      id = json['code'] as String,
      title = json['titre'] as String,
      numberOfAidsAvailable = json['nombre_aides_disponibles'] as int;

  final ActionType type;
  final String id;
  final String title;

  final int numberOfAidsAvailable;

  static List<ActionSummary> fromJsonList(final List<dynamic> jsonList) => jsonList
      .cast<Map<String, dynamic>>()
      .map(ActionSummary._fromJson)
      .where((final e) => e.type != ActionType.simulator || ActionSimulatorId.isSimulatorId(e.id))
      .toList();

  @override
  List<Object?> get props => [type, id, title, numberOfAidsAvailable];
}
