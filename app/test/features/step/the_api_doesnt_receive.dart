import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/feature_context.dart';

/// Usage: the API doesn't receive
Future<void> theApiDoesntReceive(final WidgetTester tester, final bdd.DataTable dataTable) async {
  dataTable.asMaps().forEach((final e) {
    final path = e['path'] as String;

    if (e['method'] == 'PATCH') {
      verifyNever(() => FeatureContext.instance.dioMock.patch<dynamic>(path, data: e['requestData'] ?? any(named: 'data')));

      return;
    }
    if (e['method'] == 'PUT') {
      verifyNever(() => FeatureContext.instance.dioMock.put<dynamic>(path, data: e['requestData'] ?? any(named: 'data')));

      return;
    }
    if (e['method'] == 'POST') {
      verifyNever(() => FeatureContext.instance.dioMock.post<dynamic>(path, data: e['requestData'] ?? any(named: 'data')));

      return;
    }
    if (e['method'] == 'GET') {
      verifyNever(() => FeatureContext.instance.dioMock.get<dynamic>(path, data: e['requestData'] ?? any(named: 'data')));

      return;
    }
    throw Exception('Method ${e['method']} not supported');
  });
}
