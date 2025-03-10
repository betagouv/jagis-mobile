import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';

/// Usage: I have theme with actions
Future<void> iHaveThemeWithActions(final WidgetTester tester) async {
  final name = ThemeType.transport.name;
  FeatureContext.instance.dioMock.getM(
    Endpoints.theme(name),
    responseData: {
      'thematique': name,
      'est_personnalisation_necessaire': false,
      'enchainement_questions_personnalisation': 'ENCHAINEMENT_KYC_personnalisation_transport',
      'liste_actions_recommandees': [
        {
          'nombre_actions_en_cours': 442,
          'nombre_aides_disponibles': 0,
          'code': 'action_simulateur_voiture',
          'titre': 'Trouver le **type de voiture** qui vous convient le mieux',
          'sous_titre': 'Comparez les coûts et les émissions de votre voiture à des alternatives économiques et écologiques',
          'type': 'simulateur',
          'thematique': 'transport',
          'deja_vue': true,
        },
        {
          'nombre_actions_en_cours': 640,
          'nombre_aides_disponibles': 0,
          'code': 'action_bilan_transports',
          'titre': 'Faire le bilan sur **vos habitudes de déplacements**',
          'sous_titre':
              'Répondez à des questions pour calculer les impacts de vos déplacements et vous proposer des actions adaptées',
          'type': 'bilan',
          'thematique': 'transport',
          'deja_vue': false,
        },
      ],
      'nombre_actions': 2,
      'nombre_aides': 2,
      'nombre_simulateurs': 0,
      'nom_commune': 'Dijon',
    },
  );
}
