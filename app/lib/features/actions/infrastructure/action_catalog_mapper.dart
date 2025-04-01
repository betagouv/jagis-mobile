import 'package:app/features/action/domain/action.dart';
import 'package:app/features/actions/domain/action_catalog.dart';
import 'package:app/features/actions/domain/action_filter.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/actions/infrastructure/action_summary_mapper.dart';
import 'package:fpdart/fpdart.dart';

abstract final class ActionCatalogMapper {
  const ActionCatalogMapper._();

  static ActionCatalog fromJson(final Map<String, dynamic> json) => ActionCatalog(
    actions:
        (json['actions'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(ActionSummaryMapper.fromJson)
            .where((final e) => e.type != ActionType.simulator || ActionSimulatorId.isSimulatorId(e.id))
            .toList(),
    themes:
        (json['filtres'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(
              (final e) => ActionFilter(code: e['code'] as String, label: e['label'] as String, selected: e['selected'] as bool),
            )
            .toList(),
    alreadyConsulted: json['consultation'] as String == 'vu',
  );
}
