import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';

/// Usage: I enter {"110 Rue Garibaldi"} in the autocomplete field
Future<void> iEnterInTheAutocompleteField(final WidgetTester tester, final String text) async {
  FeatureContext.instance.dioMock.getM(
    Uri.parse('https://data.geopf.fr/geocodage/search?q=$text&index=address&type=housenumber&limit=4&autocomplete=1').toString(),
    responseData: {
      'type': 'FeatureCollection',
      'features': [
        {
          'type': 'Feature',
          'geometry': {
            'type': 'Point',
            'coordinates': [4.850666, 45.766368],
          },
          'properties': {
            'label': '110 Rue Garibaldi 69006 Lyon',
            'score': 0.9732618181818182,
            'housenumber': '110',
            'id': '69386_3030_00110',
            'banId': '9898f748-bebe-43a3-aed3-9da2c5770ad8',
            'name': '110 Rue Garibaldi',
            'postcode': '69006',
            'citycode': '69386',
            'x': 843823.41,
            'y': 6520214.41,
            'city': 'Lyon',
            'district': 'Lyon 6e Arrondissement',
            'context': '69, Rhône, Auvergne-Rhône-Alpes',
            'type': 'housenumber',
            'importance': 0.70588,
            'street': 'Rue Garibaldi',
            '_type': 'address',
          },
        },
      ],
    },
  );

  final byKey = find.byKey(const ValueKey('autocomplete_input'));
  await tester.tap(byKey);
  await tester.enterText(byKey, text);
  await tester.pump(Durations.long2);
}
