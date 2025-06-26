import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/aids/core/domain/aid.dart';
import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';

/// Usage: I have actions in my library
Future<void> iHaveActionsInMyLibrary(final WidgetTester tester, final bdd.DataTable dataTable) async {
  final actions = dataTable
      .asMaps()
      .map(
        (final e) => {
          'type': e['type'],
          'code': e['code'],
          'titre': e['title'],
          'sous_titre': Faker().lorem.sentence(),
          'nombre_aides_disponibles': e['nb_aids_available'],
          'nombre_actions_faites': Faker().randomGenerator.integer(100),
          'aides': <Aid>[],
        },
      )
      .toList();
  FeatureContext.instance.dioMock.getM(
    Uri(path: Endpoints.actions).toString(),
    responseData: {
      'actions': actions,
      'filtres': [
        {'code': 'alimentation', 'label': '🥦 Alimentation', 'selected': false},
        {'code': 'transport', 'label': '🚗 Transports', 'selected': false},
        {'code': 'logement', 'label': '🏡 Logement', 'selected': false},
        {'code': 'consommation', 'label': '🛒 Consommation durable', 'selected': false},
        {'code': 'climat', 'label': '☀️ Environnement', 'selected': false},
        {'code': 'dechet', 'label': '🗑️ Déchets', 'selected': false},
        {'code': 'loisir', 'label': '⚽ Loisirs', 'selected': false},
      ],
      'consultation': 'tout',
    },
  );
}
