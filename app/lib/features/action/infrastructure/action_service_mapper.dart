import 'package:app/features/action/domain/action_service.dart';

abstract final class ActionServiceMapper {
  const ActionServiceMapper._();

  static ActionService? fromJson(final Map<String, dynamic> json) {
    final mapServiceId = _mapServiceId(json['recherche_service_id'] as String);

    if (mapServiceId == null) {
      return null;
    }

    return ActionService(id: mapServiceId, category: json['categorie'] as String);
  }

  static ServiceId? _mapServiceId(final String type) => switch (type) {
    'longue_vie_objets' => ServiceId.lvao,
    'recettes' => ServiceId.mangerBouger,
    'proximite' => ServiceId.pdcn,
    _ => null,
  };
}
