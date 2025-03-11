import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';

/// Usage: the API will return an error
Future<void> theApiWillReturnAnError(final WidgetTester tester, final bdd.DataTable dataTable) async {
  dataTable.asMaps().forEach((final e) {
    if (e['method'] == 'PATCH') {
      FeatureContext.instance.dioMock.patchM(
        e['path'] as String,
        statusCode: e['statusCode'] as int,
        responseData: e['responseData'],
      );
    }
  });
}
