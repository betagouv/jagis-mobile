import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/environmental_performance/questions/infrastructure/environment_performance_question_repository.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_bloc.dart';
import 'package:app/features/environmental_performance/questions/presentation/page/environmental_performance_question_page.dart';
import 'package:app/features/environmental_performance/summary/application/fetch_environmental_performance.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_repository.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../helpers/authentication_service_setup.dart';
import '../../helpers/dio_mock.dart';
import '../../helpers/pump_page.dart';
import '../mocks/gamification_bloc_fake.dart';
import 'environmental_performance_data.dart';

Future<void> pumpEnvironmentalPerformancePage(final WidgetTester tester, final Dio dio) async {
  final dioHttpClient = DioHttpClient(dio: dio, authenticationService: authenticationService);
  await pumpPage(
    tester: tester,
    repositoryProviders: [
      RepositoryProvider<EnvironmentalPerformanceSummaryRepository>.value(
        value: EnvironmentalPerformanceSummaryRepository(client: dioHttpClient),
      ),
    ],
    blocProviders: [
      BlocProvider<GamificationBloc>(create: (final context) => GamificationBlocFake()),
      BlocProvider(
        create:
            (final context) => EnvironmentalPerformanceBloc(
              useCase: FetchEnvironmentalPerformance(EnvironmentalPerformanceSummaryRepository(client: dioHttpClient)),
            ),
      ),
      BlocProvider(
        create:
            (final context) => EnvironmentalPerformanceQuestionBloc(
              repository: EnvironmentalPerformanceQuestionRepository(client: dioHttpClient),
            ),
      ),
    ],
    page: EnvironmentalPerformanceSummaryPage.route,
    routes: {EnvironmentalPerformanceQuestionPage.name: EnvironmentalPerformanceQuestionPage.path},
  );
  await tester.pumpAndSettle();
}

void main() {
  group('Votre bilan environnemental', () {
    for (final testCase in [
      (
        header: EnvironmentalPerformanceSummaryL10n.quEstCeQuUn,
        expected: 'Que l’on se rende dans un magasin de quartier pour faire ses courses',
      ),
      (
        header: EnvironmentalPerformanceSummaryL10n.commentEstCalcule,
        expected: 'Votre bilan environnemental est calculé à partir',
      ),
    ]) {
      testWidgets('Voir le contenu de ${testCase.header}', (final tester) async {
        await mockNetworkImages(() async {
          final dio = DioMock()..getM(Endpoints.bilan, responseData: environmentalPerformancePartialData);

          await pumpEnvironmentalPerformancePage(tester, dio);
          await tester.scrollUntilVisible(
            find.text(testCase.header),
            300,
            scrollable: find.descendant(of: find.byType(ListView), matching: find.byType(Scrollable).first),
          );
          await tester.pumpAndSettle();
          await tester.tap(find.text(testCase.header));
          await tester.pumpAndSettle();
          expect(find.textContaining(testCase.expected), findsOneWidget);
        });
      });
    }

    testWidgets('Voir le contenu de Estimer mon bilan environnemental avec un bilan partiel', (final tester) async {
      await mockNetworkImages(() async {
        final dio = DioMock()..getM(Endpoints.bilan, responseData: environmentalPerformancePartialData);
        await pumpEnvironmentalPerformancePage(tester, dio);
        expect(find.text('Estimer mon bilan environnemental'), findsOneWidget);
        expect(find.text('Faible'), findsOneWidget);
        expect(find.text('Moyen'), findsOneWidget);
        expect(find.text('Fort'), findsOneWidget);
        expect(find.text('Très fort'), findsNothing);
        expect(find.text('✨ Estimation complète à 23%'), findsOneWidget);
        expect(find.text('Transport'), findsOneWidget);
      });
    });

    testWidgets('Aller sur les questions du Mes déplacements avec un bilan partiel', (final tester) async {
      await mockNetworkImages(() async {
        final dio =
            DioMock()
              ..getM(Endpoints.bilan, responseData: environmentalPerformancePartialData)
              ..getM(
                Endpoints.questions('ENCHAINEMENT_KYC_bilan_transport'),
                responseData: [
                  {
                    'code': 'KYC_transport_avion_3_annees',
                    'question': "Avez-vous pris l'avion au moins une fois ces 3 dernières années ?",
                    'reponse_multiple': [
                      {'code': 'oui', 'label': 'Oui', 'selected': false},
                      {'code': 'non', 'label': 'Non', 'selected': false},
                      {'code': 'ne_sais_pas', 'label': 'Je ne sais pas', 'selected': false},
                    ],
                    'is_answered': false,
                    'categorie': 'mission',
                    'points': 5,
                    'type': 'choix_unique',
                    'is_NGC': true,
                    'thematique': 'transport',
                  },
                  {
                    'code': 'KYC_transport_type_utilisateur',
                    'question': 'Utilisez-vous majoritairement la même voiture pour vous déplacer ?',
                    'reponse_multiple': [
                      {'code': 'proprio', 'label': "Oui et j'en suis propriétaire", 'selected': false},
                      {'code': 'pas_la_mienne', 'label': "Oui mais ce n'est pas la mienne", 'selected': false},
                      {
                        'code': 'change_souvent',
                        'label': 'Non, je change souvent (autopartage, proches, taxi...)',
                        'selected': false,
                      },
                    ],
                    'is_answered': false,
                    'categorie': 'test',
                    'points': 5,
                    'type': 'choix_unique',
                    'is_NGC': true,
                    'thematique': 'transport',
                  },
                  {
                    'code': 'KYC_transport_voiture_nbr_voyageurs',
                    'question': 'Quel est le nombre moyen de voyageurs dans la voiture ?',
                    'reponse_unique': <String, dynamic>{},
                    'is_answered': false,
                    'categorie': 'test',
                    'points': 5,
                    'type': 'entier',
                    'is_NGC': true,
                    'thematique': 'transport',
                  },
                  {
                    'code': 'KYC_transport_heures_avion_court',
                    'question': "Sur une année, combien d'heures voyagez-vous sur des vols de moins de 2h (court-courrier) ?",
                    'reponse_unique': <String, dynamic>{},
                    'is_answered': false,
                    'categorie': 'test',
                    'points': 5,
                    'type': 'entier',
                    'is_NGC': true,
                    'thematique': 'transport',
                  },
                  {
                    'code': 'KYC_transport_heures_avion_moyen',
                    'question': "Sur une année, combien d'heures voyagez-vous sur des vols entre 2 et 6h (moyen-courrier) ?",
                    'reponse_unique': <String, dynamic>{},
                    'is_answered': false,
                    'categorie': 'test',
                    'points': 5,
                    'type': 'entier',
                    'is_NGC': true,
                    'thematique': 'transport',
                  },
                  {
                    'code': 'KYC_transport_heures_avion_long',
                    'question': "Sur une année, combien d'heures voyagez-vous sur des vols de plus de 6h (long-courrier) ?",
                    'reponse_unique': <String, dynamic>{},
                    'is_answered': false,
                    'categorie': 'recommandation',
                    'points': 5,
                    'type': 'entier',
                    'is_NGC': true,
                    'thematique': 'transport',
                  },
                  {
                    'code': 'KYC_transport_2roues_usager',
                    'question': 'Utilisez-vous un scooter ou une moto ?',
                    'reponse_multiple': [
                      {'code': 'oui', 'label': 'Oui', 'selected': false},
                      {'code': 'non', 'label': 'Non', 'selected': false},
                      {'code': 'ne_sais_pas', 'label': 'Je ne souhaite pas répondre', 'selected': false},
                    ],
                    'is_answered': false,
                    'categorie': 'test',
                    'points': 5,
                    'type': 'choix_unique',
                    'is_NGC': true,
                    'thematique': 'transport',
                  },
                ],
              );
        await pumpEnvironmentalPerformancePage(tester, dio);
        await tester.pumpAndSettle();
        await tester.scrollUntilVisible(
          find.text('7 questions'),
          300,
          scrollable: find.descendant(of: find.byType(ListView), matching: find.byType(Scrollable).first),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('7 questions'));
        await tester.pumpAndSettle();

        expect(find.text('route: ${EnvironmentalPerformanceQuestionPage.name}'), findsOneWidget);
      });
    });

    testWidgets('Voir le contenu de Bilan environnemental', (final tester) async {
      final dio = DioMock()..getM(Endpoints.bilan, responseData: environmentalPerformanceFullData);
      await mockNetworkImages(() async {
        await pumpEnvironmentalPerformancePage(tester, dio);
        expect(find.text(Localisation.monBilanEnvironnemental), findsOneWidget);
        expect(find.text('2,9'), findsOneWidget);
        expect(find.text('Voiture'), findsOneWidget);
        await tester.scrollUntilVisible(
          find.text('Services sociétaux'),
          300,
          scrollable: find.descendant(of: find.byType(ListView), matching: find.byType(Scrollable).first),
        );
        await tester.pumpAndSettle();
        expect(find.text('Services sociétaux'), findsOneWidget);
        await tester.tap(find.text('Services sociétaux'));
        await tester.pumpAndSettle();
        expect(find.text('Services publics'), findsOneWidget);
      });
    });

    testWidgets('Aller sur les questions du Mes déplacements avec un bilan complet', (final tester) async {
      await mockNetworkImages(() async {
        final dio =
            DioMock()
              ..getM(Endpoints.bilan, responseData: environmentalPerformanceFullData)
              ..getM(
                Endpoints.questions('ENCHAINEMENT_KYC_bilan_transport'),
                responseData: [
                  {
                    'code': 'KYC_transport_avion_3_annees',
                    'question': "Avez-vous pris l'avion au moins une fois ces 3 dernières années ?",
                    'reponse_multiple': [
                      {'code': 'oui', 'label': 'Oui', 'selected': false},
                      {'code': 'non', 'label': 'Non', 'selected': false},
                      {'code': 'ne_sais_pas', 'label': 'Je ne sais pas', 'selected': false},
                    ],
                    'is_answered': false,
                    'categorie': 'mission',
                    'points': 5,
                    'type': 'choix_unique',
                    'is_NGC': true,
                    'thematique': 'transport',
                  },
                  {
                    'code': 'KYC_transport_type_utilisateur',
                    'question': 'Utilisez-vous majoritairement la même voiture pour vous déplacer ?',
                    'reponse_multiple': [
                      {'code': 'proprio', 'label': "Oui et j'en suis propriétaire", 'selected': false},
                      {'code': 'pas_la_mienne', 'label': "Oui mais ce n'est pas la mienne", 'selected': false},
                      {
                        'code': 'change_souvent',
                        'label': 'Non, je change souvent (autopartage, proches, taxi...)',
                        'selected': false,
                      },
                    ],
                    'is_answered': false,
                    'categorie': 'test',
                    'points': 5,
                    'type': 'choix_unique',
                    'is_NGC': true,
                    'thematique': 'transport',
                  },
                  {
                    'code': 'KYC_transport_voiture_nbr_voyageurs',
                    'question': 'Quel est le nombre moyen de voyageurs dans la voiture ?',
                    'reponse_unique': <String, dynamic>{},
                    'is_answered': false,
                    'categorie': 'test',
                    'points': 5,
                    'type': 'entier',
                    'is_NGC': true,
                    'thematique': 'transport',
                  },
                  {
                    'code': 'KYC_transport_heures_avion_court',
                    'question': "Sur une année, combien d'heures voyagez-vous sur des vols de moins de 2h (court-courrier) ?",
                    'reponse_unique': <String, dynamic>{},
                    'is_answered': false,
                    'categorie': 'test',
                    'points': 5,
                    'type': 'entier',
                    'is_NGC': true,
                    'thematique': 'transport',
                  },
                  {
                    'code': 'KYC_transport_heures_avion_moyen',
                    'question': "Sur une année, combien d'heures voyagez-vous sur des vols entre 2 et 6h (moyen-courrier) ?",
                    'reponse_unique': <String, dynamic>{},
                    'is_answered': false,
                    'categorie': 'test',
                    'points': 5,
                    'type': 'entier',
                    'is_NGC': true,
                    'thematique': 'transport',
                  },
                  {
                    'code': 'KYC_transport_heures_avion_long',
                    'question': "Sur une année, combien d'heures voyagez-vous sur des vols de plus de 6h (long-courrier) ?",
                    'reponse_unique': <String, dynamic>{},
                    'is_answered': false,
                    'categorie': 'recommandation',
                    'points': 5,
                    'type': 'entier',
                    'is_NGC': true,
                    'thematique': 'transport',
                  },
                  {
                    'code': 'KYC_transport_2roues_usager',
                    'question': 'Utilisez-vous un scooter ou une moto ?',
                    'reponse_multiple': [
                      {'code': 'oui', 'label': 'Oui', 'selected': false},
                      {'code': 'non', 'label': 'Non', 'selected': false},
                      {'code': 'ne_sais_pas', 'label': 'Je ne souhaite pas répondre', 'selected': false},
                    ],
                    'is_answered': false,
                    'categorie': 'test',
                    'points': 5,
                    'type': 'choix_unique',
                    'is_NGC': true,
                    'thematique': 'transport',
                  },
                ],
              );
        await pumpEnvironmentalPerformancePage(tester, dio);
        await tester.pumpAndSettle();
        await tester.scrollUntilVisible(
          find.text('7 questions'),
          300,
          scrollable: find.descendant(of: find.byType(ListView), matching: find.byType(Scrollable).first),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('7 questions'));
        await tester.pumpAndSettle();

        expect(find.text('route: ${EnvironmentalPerformanceQuestionPage.name}'), findsOneWidget);
      });
    });

    testWidgets("Voir le contenu respect l'accessiblité", (final tester) async {
      final dio = DioMock()..getM(Endpoints.bilan, responseData: environmentalPerformanceFullData);
      await pumpEnvironmentalPerformancePage(tester, dio);
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    });
  });
}
