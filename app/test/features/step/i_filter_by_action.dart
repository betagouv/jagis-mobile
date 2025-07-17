import 'package:app/features/aids/core/domain/aid.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';
import 'i_tap_on.dart';

/// Usage: I filter by {'Déjà consultées'} action
Future<void> iFilterByAction(final WidgetTester tester, final String theme) async {
  FeatureContext.instance.dioMock.getM(
    '/utilisateurs/%7BuserId%7D/actions?consultation=vu',
    responseData: {
      'actions': [
        {
          'type': 'classique',
          'code': '3',
          'emoji': '🌧️',
          'titre': 'Tester une nouvelle recette végétarienne',
          'sous_titre': Faker().lorem.sentence(),
          'nombre_aides_disponibles': 1,
          'nombre_actions_faites': Faker().randomGenerator.integer(100),
          'aides': <Aid>[],
        },
      ],
      'filtres': [
        {'code': 'alimentation', 'label': '🥦 Alimentation', 'selected': false},
        {'code': 'transport', 'label': '🚗 Transports', 'selected': false},
        {'code': 'logement', 'label': '🏡 Logement', 'selected': false},
        {'code': 'consommation', 'label': '🛒 Consommation durable', 'selected': false},
        {'code': 'climat', 'label': '☀️ Environnement', 'selected': false},
        {'code': 'dechet', 'label': '🗑️ Déchets', 'selected': false},
        {'code': 'loisir', 'label': '⚽ Loisirs', 'selected': false},
      ],
      'consultation': 'vu',
    },
  );
  await iTapOn(tester, theme);
}
