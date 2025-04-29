import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/feature_context.dart';

/// Usage: Url launcher launches {'https://api.aux-alentours.1934.io/report/pdf/v2/_byLatLon?lat=47.10341&lon=5.480833'}
Future<void> urlLauncherLaunches(final WidgetTester tester, final String url) async {
  verify(() => FeatureContext.instance.urlLauncherMock.launchUrl(url, any()));
}
