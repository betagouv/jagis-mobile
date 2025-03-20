import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/aids/core/domain/aid.dart';
import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';

/// Usage: I have action detail in my library
Future<void> iHaveActionDetailInMyLibrary(final WidgetTester tester, final bdd.DataTable dataTable) async {
  dataTable
      .asMaps()
      .map(
        (final e) => {
          'code': e['id'],
          'titre': e['title'],
          'sous_titre': e['subTitle'],
          'comment': e['how'],
          'pourquoi': e['why'],
          'deja_vue': false,
          'deja_faite': false,
          'nombre_actions_faites': 2,
          'points': 10,
          'consigne': e['instruction'] ?? '',
          'label_compteur': e['scoreLabel'] ?? '',
          'services': [
            {'recherche_service_id': e['service_id'], 'categorie': e['service_category']},
          ],
          'aides': <Aid>[],
        },
      )
      .forEach((final e) {
        FeatureContext.instance.dioMock.getM(Endpoints.action(type: 'classique', code: e['code'] as String), responseData: e);
      });
}
