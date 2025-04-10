import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/aids/core/domain/aid.dart';
import 'package:app/l10n/l10n.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';
import 'i_enter_in_the_search_bar.dart';

/// Usage: I enter {'végétarienne'} in the search by title field actions
Future<void> iEnterInTheSearchByTitleFieldActions(final WidgetTester tester, final String text) async {
  FeatureContext.instance.dioMock.getM(
    Uri(path: Endpoints.actions, queryParameters: {'titre': text}).toString(),
    responseData: {
      'actions': [
        {
          'type': 'classique',
          'code': '3',
          'titre': 'Tester une nouvelle recette végétarienne',
          'sous_titre': Faker().lorem.sentence(),
          'nombre_aides_disponibles': 1,
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
      'consultation': 'tout',
    },
  );
  await iEnterInTheSearchBar(tester, text, Localisation.rechercherParTitre);
  await tester.pumpAndSettle(Durations.long2);
}
