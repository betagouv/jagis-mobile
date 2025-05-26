import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';

/// Usage: the API will return
Future<void> theApiWillReturn(final WidgetTester tester, final bdd.DataTable dataTable) async {
  dataTable.asMaps().forEach((final e) {
    final path = e['path'] as String;
    final statusCode = e['statusCode'] as int;
    final requestData = e.containsKey('requestData') ? e['requestData'] : null;
    final responseData = e['responseData'];
    final methodHandlers = {
      'GET': () => FeatureContext.instance.dioMock.getM(path, statusCode: statusCode, responseData: responseData),
      'PATCH': () => FeatureContext.instance.dioMock.patchM(path, statusCode: statusCode, responseData: responseData),
      'POST': () => FeatureContext.instance.dioMock.postM(
        path,
        statusCode: statusCode,
        requestData: requestData,
        responseData: responseData,
      ),
      'PUT': () => FeatureContext.instance.dioMock.putM(path, statusCode: statusCode),
    };

    final method = e['method'] as String;
    final handler = methodHandlers[method];
    if (handler == null) {
      throw Exception('Method $method not supported');
    }
    handler();
  });
}
