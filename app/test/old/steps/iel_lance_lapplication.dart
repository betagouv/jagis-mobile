import 'package:app/app/app.dart';
import 'package:app/app/router/deep_link.dart';
import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/authentication/domain/authentication_status.dart';
import 'package:app/core/authentication/infrastructure/authentication_storage.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:clock/clock.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../environmental_performance/summary/environmental_performance_data.dart';
import '../../features/helper/flutter_secure_storage_fake.dart';
import '../../features/helper/notification_service_fake.dart';
import '../../features/helper/package_info_fake.dart';
import '../../features/helper/timed_delay_fake.dart';
import '../api/constants.dart';
import 'scenario_context.dart';

class _TrackerMock extends Mock implements Tracker {}

/// Iel lance l'application.
Future<void> ielLanceLapplication(final WidgetTester tester) async {
  final clock = Clock.fixed(DateTime(1992));
  ScenarioContext().clock = clock;
  final authenticationService = AuthenticationService(
    authenticationStorage: AuthenticationStorage(FlutterSecureStorageFake()),
    clock: clock,
  );
  if (ScenarioContext().authentificationStatut is Authenticated) {
    await authenticationService.login(token);
  }

  final tracker = _TrackerMock();
  when(() => tracker.navigatorObserver).thenAnswer((final _) => RouteObserver<ModalRoute<void>>());
  final aid = {
    'content_id': '1',
    'titre': 'Acheter un vélo',
    'contenu':
        "<p>Vous souhaitez acheter un vélo neuf ou d'occasion, qu'il soit électrique ou classique ? Cette aide est faite pour vous !</p><p></p><h3><strong>Votre éligibilité</strong></h3><p><strong>1 aide nationale disponible</strong> pour les <strong>majeurs, domiciliés en France</strong></p><p><strong>Plusieurs aides sous conditions</strong></p><p></p><h3><strong>Types de vélo</strong></h3><ul><li><p>Mécanique / Électrique</p></li><li><p>Classique / Pliant / Cargo</p></li></ul><p></p><h3><strong>En quoi cela a de l'impact ?</strong></h3><p>Le vélo est un des moyens de transport les moins carbonés.</p><p>Il peut remplacer la voiture dans de nombreux cas et c'est bon pour la santé !</p>",
    'url_simulateur': '/aides/velo',
    'thematiques': ['transport'],
    'montant_max': 1500,
    'est_gratuit': false,
  };
  ScenarioContext().dioMock!
    ..getM(Endpoints.bilan, responseData: environmentalPerformancePartialData)
    ..getM(
      Endpoints.utilisateur,
      responseData: {
        'prenom': 'Lucas',
        'is_onboarding_done': true,
        'is_nom_prenom_modifiable': true,
        'popup_reset_est_vue': true,
      },
    )
    ..getM('/utilisateurs/%7BuserId%7D/recommandations_v3?nombre_max=4&type=article', responseData: <dynamic>[])
    ..getM(
      '/utilisateurs/%7BuserId%7D/actions?realisation=pas_faite&recommandation=recommandee&take=6',
      responseData: {'actions': <dynamic>[]},
    )
    ..getM(
      Endpoints.homeBoard,
      responseData: {
        'nom_commune': 'Dole',
        'total_national_actions_faites': 1,
        'total_utilisateur_actions_faites': 2,
        'pourcentage_bilan_done': 0,
        'bilan_carbone_total_kg': 10.5,
        'nombre_aides': 3,
        'nombre_recettes': 4,
        'pourcentage_alimentation_reco_done': 0,
        'pourcentage_consommation_reco_done': 0,
        'pourcentage_logement_reco_done': 0,
        'pourcentage_transport_reco_done': 0,
        'pourcentage_global_reco_done': 0,
      },
    )
    ..getM(Endpoints.gamification, responseData: {'points': 650})
    ..getM(
      Endpoints.aids,
      responseData: {
        'couverture_aides_ok': true,
        'liste_aides': <Map<String, dynamic>>[aid],
      },
    )
    ..getM(Endpoints.aid(aid['content_id']! as String), responseData: aid)
    ..getM(
      Endpoints.theme(ThemeType.alimentation.name),
      responseData: {
        'thematique': 'alimentation',
        'est_personnalisation_necessaire': true,
        'enchainement_questions_personnalisation': 'ENCHAINEMENT_KYC_personnalisation_alimentation',
        'liste_actions_recommandees': <dynamic>[],
        'nombre_actions': 5,
        'nombre_aides': 0,
        'nombre_simulateurs': 0,
        'nom_commune': 'Dole',
      },
    )
    ..getM(Endpoints.questions('ENCHAINEMENT_KYC_personnalisation_alimentation'), responseData: <dynamic>[]);

  final dioMock = ScenarioContext().dioMock!;
  await mockNetworkImages(() async {
    await tester.pumpFrames(
      App(
        clock: clock,
        tracker: tracker,
        deepLink: DeepLink(),
        messageBus: MessageBus(),
        apiClient: DioHttpClient(dio: dioMock, authenticationService: authenticationService),
        addressClient: dioMock,
        packageInfo: const PackageInfoFake(version: '1.2.3', buildNumber: '4'),
        notificationService: const NotificationServiceFake(AuthorizationStatus.denied),
        authenticationService: authenticationService,
        timedDelay: const TimedDelayFake(),
      ),
      Durations.short1,
    );
  });
}
