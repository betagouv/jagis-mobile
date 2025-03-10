import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';

/// Usage: I have theme with no action
Future<void> iHaveThemeWithNoAction(final WidgetTester tester) async {
  final name = ThemeType.transport.name;
  FeatureContext.instance.dioMock.getM(
    Endpoints.theme(name),
    responseData: {
      'thematique': name,
      'est_personnalisation_necessaire': false,
      'enchainement_questions_personnalisation': 'ENCHAINEMENT_KYC_personnalisation_transport',
      'liste_actions_recommandees': <dynamic>[],
      'nombre_actions': 2,
      'nombre_aides': 2,
      'nombre_simulateurs': 0,
      'nom_commune': 'Dijon',
    },
  );
}
