import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/feature_context.dart';

/// Usage: the API receives
Future<void> theApiReceives(final WidgetTester tester, final bdd.DataTable dataTable) async {
  dataTable.asMaps().forEach((final e) {
    if (e['method'] == 'PATCH') {
      verify(() => FeatureContext.instance.dioMock.patch<dynamic>(e['path'] as String, data: e['requestData']));

      return;
    }
    if (e['method'] == 'PUT') {
      verify(() => FeatureContext.instance.dioMock.put<dynamic>(e['path'] as String, data: e['requestData']));

      return;
    }
    if (e['method'] == 'POST') {
      verify(() => FeatureContext.instance.dioMock.post<dynamic>(e['path'] as String, data: e['requestData']));

      return;
    }
    if (e['method'] == 'GET') {
      verify(() => FeatureContext.instance.dioMock.get<dynamic>(e['path'] as String, data: e['requestData']));

      return;
    }
    throw Exception('Method ${e['method']} not supported');
  });
}
