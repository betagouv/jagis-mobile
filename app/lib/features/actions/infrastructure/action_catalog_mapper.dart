import 'package:app/features/actions/domain/action_catalog.dart';
import 'package:app/features/actions/domain/action_filter.dart';
import 'package:app/features/actions/infrastructure/action_summary_mapper.dart';

abstract final class ActionCatalogMapper {
  const ActionCatalogMapper._();

  static ActionCatalog fromJson(final Map<String, dynamic> json) => ActionCatalog(
    actions: ActionSummaryMapper.fromJsonList(json['actions'] as List<dynamic>),
    themes: (json['filtres'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map((final e) => ActionFilter(code: e['code'] as String, label: e['label'] as String, selected: e['selected'] as bool))
        .toList(),
    alreadyConsulted: json['consultation'] as String == 'vu',
  );
}
