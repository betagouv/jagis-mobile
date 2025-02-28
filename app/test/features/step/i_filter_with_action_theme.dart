import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';
import 'i_tap_on.dart';

/// Usage: I filter with {'🍛 Me nourrir'} action theme
Future<void> iFilterWithActionTheme(final WidgetTester tester, final String theme) async {
  FeatureContext.instance.dioMock.getM(
    '/utilisateurs/%7BuserId%7D/actions?thematique=alimentation',
    responseData: {
      'actions': [
        {
          'type': 'classique',
          'code': '3',
          'titre': 'Tester une nouvelle recette végétarienne',
          'sous_titre': Faker().lorem.sentence(),
          'nombre_aides_disponibles': 1,
        },
      ],
      'filtres': [
        {'code': 'alimentation', 'label': '🥦 Alimentation', 'selected': true},
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
  await iTapOn(tester, theme);
}
