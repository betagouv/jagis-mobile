import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/notifications/infrastructure/notification_service.dart';
import 'package:app/features/environmental_performance/questions/infrastructure/environment_performance_question_repository.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_bloc.dart';
import 'package:app/features/environmental_performance/summary/application/fetch_environmental_performance.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_repository.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/home/infrastructure/home_dashboard_repository.dart';
import 'package:app/features/home/presentation/pages/home_page.dart';
import 'package:app/features/recommandations/infrastructure/recommandations_repository.dart';
import 'package:app/features/utilisateur/infrastructure/user_repository.dart';
import 'package:app/features/utilisateur/presentation/bloc/user_bloc.dart';
import 'package:app/l10n/l10n.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../features/helper/notification_service_fake.dart';
import '../../helpers/authentication_service_setup.dart';
import '../../helpers/dio_mock.dart';
import '../../helpers/pump_page.dart';
import '../mocks/gamification_bloc_fake.dart';
import '../summary/environmental_performance_data.dart';

Future<void> pumpHomePage(final WidgetTester tester) async {
  final dio =
      DioMock()
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
          Endpoints.homeBoard,
          responseData: {
            'nom_commune': 'Dole',
            'total_national_actions_faites': 1,
            'total_utilisateur_actions_faites': 2,
            'pourcentage_bilan_done': 0,
            'bilan_carbone_total_kg': 10.5,
            'nombre_aides': 3,
            'nombre_recettes': 4,
          },
        )
        ..getM(Endpoints.bilan, responseData: environmentalPerformanceEmptyData);

  final client = DioHttpClient(dio: dio, authenticationService: authenticationService);
  final recommandationsRepository = RecommandationsRepository(client);
  await pumpPage(
    tester: tester,
    repositoryProviders: [
      RepositoryProvider<EnvironmentalPerformanceSummaryRepository>.value(
        value: EnvironmentalPerformanceSummaryRepository(client),
      ),
      RepositoryProvider<NotificationService>(
        create: (final context) => const NotificationServiceFake(AuthorizationStatus.denied),
      ),
      RepositoryProvider<HomeDashboardRepository>(create: (final context) => HomeDashboardRepository(client)),
      RepositoryProvider<RecommandationsRepository>.value(value: recommandationsRepository),
    ],
    blocProviders: [
      BlocProvider<GamificationBloc>(create: (final context) => GamificationBlocFake()),
      BlocProvider(create: (final context) => UserBloc(repository: UserRepository(client))),
      BlocProvider(
        create:
            (final context) => EnvironmentalPerformanceBloc(
              useCase: FetchEnvironmentalPerformance(EnvironmentalPerformanceSummaryRepository(client)),
            ),
      ),
      BlocProvider(
        create:
            (final context) =>
                EnvironmentalPerformanceQuestionBloc(repository: EnvironmentalPerformanceQuestionRepository(client)),
      ),
    ],
    router: GoRouter(
      routes: [
        HomePage.route(
          routes: [
            GoRoute(
              path: EnvironmentalPerformanceSummaryPage.path,
              name: EnvironmentalPerformanceSummaryPage.name,
              builder: (final context, final state) => const Text('route: ${EnvironmentalPerformanceSummaryPage.name}'),
            ),
          ],
        ),
      ],
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  group("Empreinte écologique sur la page d'accueil", () {
    testWidgets('Aller sur les questions du mini bilan', (final tester) async {
      await mockNetworkImages(() async {
        await pumpHomePage(tester);
        expect(find.text(Localisation.monEmpreinteEcologique), findsOneWidget);
        await tester.tap(find.textContaining(Localisation.completer));
        await tester.pumpAndSettle();

        expect(find.text('route: ${EnvironmentalPerformanceSummaryPage.name}'), findsOneWidget);
      });
    });
  });
}
