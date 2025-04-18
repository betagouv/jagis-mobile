import 'dart:async';

import 'package:app/app/router/app_router.dart';
import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/authentication/infrastructure/authentication_injection.dart';
import 'package:app/core/authentication/infrastructure/authentication_redirection.dart';
import 'package:app/core/authentication/presentation/restart_widget.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/core/infrastructure/timed_delay.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/core/notifications/domain/notification_data.dart';
import 'package:app/core/notifications/infrastructure/notification_repository.dart';
import 'package:app/core/notifications/infrastructure/notification_service.dart';
import 'package:app/core/question/infrastructure/question_repository.dart';
import 'package:app/features/action/infrastructure/action_repository.dart';
import 'package:app/features/action/presentation/pages/action_page.dart';
import 'package:app/features/actions/infrastructure/actions_repository.dart';
import 'package:app/features/aids/list/infrastructure/aids_repository.dart';
import 'package:app/features/aids/list/presentation/bloc/aids_disclaimer/aids_disclaimer_cubit.dart';
import 'package:app/features/articles/infrastructure/articles_repository.dart';
import 'package:app/features/articles/presentation/pages/article_page.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_repository.dart';
import 'package:app/features/car_simulator/infrastructure/car_simulator_repository.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/bloc/car_simulator_result_bloc.dart';
import 'package:app/features/communes/infrastructure/communes_repository.dart';
import 'package:app/features/environmental_performance/action/infrastructure/action_performance_repository.dart';
import 'package:app/features/environmental_performance/questions/infrastructure/environment_performance_question_repository.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_bloc.dart';
import 'package:app/features/environmental_performance/summary/application/fetch_environmental_performance.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_repository.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/gamification/infrastructure/gamification_repository.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_event.dart';
import 'package:app/features/gamification/reset/infrastructure/reset_repository.dart';
import 'package:app/features/home/infrastructure/home_dashboard_repository.dart';
import 'package:app/features/know_your_customer/list/infrastructure/know_your_customers_repository.dart';
import 'package:app/features/library/infrastructure/library_repository.dart';
import 'package:app/features/onboarding/pseudonym/infrastructure/onboarding_pseudonym_repository.dart';
import 'package:app/features/profil/core/infrastructure/profil_repository.dart';
import 'package:app/features/quiz/infrastructure/quiz_repository.dart';
import 'package:app/features/quiz/infrastructure/quizzes_repository.dart';
import 'package:app/features/ranking/infrastructure/ranking_repository.dart';
import 'package:app/features/recommandations/infrastructure/recommandations_repository.dart';
import 'package:app/features/services/lvao/infrastructure/lvao_repository.dart';
import 'package:app/features/services/pres_de_chez_vous/infrastructure/action_pres_de_chez_vous_repository.dart';
import 'package:app/features/services/recipes/action/infrastructure/action_recipes_repository.dart';
import 'package:app/features/services/recipes/item/infrastructure/recipe_repository.dart';
import 'package:app/features/services/recipes/list/infrastructure/recipes_repository.dart';
import 'package:app/features/services/seasonal_fruits_and_vegetables/infrastructure/seasonal_fruits_and_vegetables_repository.dart';
import 'package:app/features/simulateur_velo/infrastructure/aide_velo_repository.dart';
import 'package:app/features/simulateur_velo/presentation/bloc/aide_velo_bloc.dart';
import 'package:app/features/theme/core/infrastructure/theme_repository.dart';
import 'package:app/features/upgrade/infrastructure/upgrade_interceptor.dart';
import 'package:app/features/upgrade/presentation/bloc/upgrade_bloc.dart';
import 'package:app/features/upgrade/presentation/widgets/upgrade_widget.dart';
import 'package:app/features/utilisateur/infrastructure/user_repository.dart';
import 'package:app/features/utilisateur/presentation/bloc/user_bloc.dart';
import 'package:app/features/version/infrastructure/version_repository.dart';
import 'package:app/features/version/presentation/bloc/version_bloc.dart';
import 'package:app/features/version/presentation/bloc/version_event.dart';
import 'package:clock/clock.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.clock,
    required this.tracker,
    required this.messageBus,
    required this.dioHttpClient,
    required this.packageInfo,
    required this.notificationService,
    required this.authenticationService,
    required this.timedDelay,
  });

  final Clock clock;
  final Tracker tracker;
  final MessageBus messageBus;
  final DioHttpClient dioHttpClient;
  final PackageInfo packageInfo;
  final NotificationService notificationService;
  final AuthenticationService authenticationService;
  final TimedDelay timedDelay;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _goRouter;
  late final StreamSubscription<NotificationData> _messageOpenedSubscription;

  @override
  void initState() {
    super.initState();
    _goRouter = goRouter(tracker: widget.tracker);
    _messageOpenedSubscription = widget.notificationService.onMessageOpenedApp.listen((final event) async {
      widget.tracker.trackNotificationOpened('${event.runtimeType} - ${event.pageId}');

      await _handleNotification(goRouter: _goRouter, data: event);
    });
  }

  Future<void> _handleNotification({required final GoRouter goRouter, required final NotificationData data}) async {
    switch (data) {
      case ArticleNotificationData():
        await _handleArticleNotification(goRouter, data);
      case ActionNotificationData():
        await _handleActionNotification(goRouter, data);
    }
  }

  Future<void> _handleArticleNotification(final GoRouter goRouter, final ArticleNotificationData data) async {
    await goRouter.pushNamed(ArticlePage.name, pathParameters: ArticlePage.pathParameters(id: data.pageId));
  }

  Future<void> _handleActionNotification(final GoRouter goRouter, final ActionNotificationData data) async {
    await goRouter.pushNamed(ActionPage.name, pathParameters: ActionPage.pathParameters(type: data.actionType, id: data.pageId));
  }

  @override
  void dispose() {
    unawaited(_messageOpenedSubscription.cancel());
    _goRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    const locale = Locale('fr', 'FR');

    final upgradeBloc = UpgradeBloc();
    widget.dioHttpClient.add(UpgradeInterceptor(upgradeBloc));

    final communesRepository = CommunesRepository(widget.dioHttpClient);
    final profilRepository = ProfilRepository(widget.dioHttpClient);
    final environmentalPerformanceSummaryRepository = EnvironmentalPerformanceSummaryRepository(widget.dioHttpClient);

    return InheritedGoRouter(
      goRouter: _goRouter,
      child: AuthenticationInjection(
        authenticationService: widget.authenticationService,
        child: RestartWidget(
          child: AuthenticationRedirection(
            child: MultiRepositoryProvider(
              providers: [
                RepositoryProvider.value(value: widget.clock),
                RepositoryProvider.value(value: widget.timedDelay),
                RepositoryProvider.value(value: widget.messageBus),
                RepositoryProvider.value(value: widget.dioHttpClient),
                RepositoryProvider.value(value: widget.notificationService),
                RepositoryProvider.value(value: widget.tracker),
                RepositoryProvider.value(value: communesRepository),
                RepositoryProvider.value(value: profilRepository),
                RepositoryProvider.value(value: environmentalPerformanceSummaryRepository),
                RepositoryProvider(create: (final context) => AidsRepository(widget.dioHttpClient)),
                RepositoryProvider(create: (final context) => ActionsRepository(widget.dioHttpClient)),
                RepositoryProvider(create: (final context) => RecommandationsRepository(widget.dioHttpClient)),
                RepositoryProvider(create: (final context) => RankingRepository(widget.dioHttpClient)),
                RepositoryProvider(create: (final context) => QuizRepository(widget.dioHttpClient)),
                RepositoryProvider(create: (final context) => QuestionRepository(widget.dioHttpClient)),
                RepositoryProvider(create: (final context) => KnowYourCustomersRepository(widget.dioHttpClient)),
                RepositoryProvider(create: (final context) => OnboardingPseudonymRepository(widget.dioHttpClient)),
                RepositoryProvider(
                  create:
                      (final context) => AuthentificationRepository(
                        client: widget.dioHttpClient,
                        authenticationService: widget.authenticationService,
                      ),
                ),
                RepositoryProvider(create: (final context) => ThemeRepository(widget.dioHttpClient)),
                RepositoryProvider(create: (final context) => ActionRepository(widget.dioHttpClient, widget.messageBus)),
                RepositoryProvider(create: (final context) => LvaoRepository(widget.dioHttpClient)),
                RepositoryProvider(create: (final context) => ActionPresDeChezVousRepository(widget.dioHttpClient)),
                RepositoryProvider(create: (final context) => ActionRecipesRepository(widget.dioHttpClient)),
                RepositoryProvider(create: (final context) => RecipesRepository(widget.dioHttpClient)),
                RepositoryProvider(create: (final context) => RecipeRepository(widget.dioHttpClient)),
                RepositoryProvider(create: (final context) => ArticlesRepository(widget.dioHttpClient)),
                RepositoryProvider(create: (final context) => QuizzesRepository(widget.dioHttpClient)),
                RepositoryProvider(
                  create:
                      (final context) =>
                          NotificationRepository(client: widget.dioHttpClient, notificationService: widget.notificationService),
                ),
                RepositoryProvider(create: (final context) => SeasonalFruitsAndVegetablesRepository(widget.dioHttpClient)),
                RepositoryProvider(create: (final context) => ActionPerformanceRepository(widget.dioHttpClient)),
                RepositoryProvider(create: (final context) => ResetRepository(widget.dioHttpClient)),
                RepositoryProvider(create: (final context) => HomeDashboardRepository(widget.dioHttpClient)),
                RepositoryProvider(create: (final context) => LibraryRepository(widget.dioHttpClient)),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: upgradeBloc),
                  BlocProvider(create: (final context) => AidsDisclaimerCubit()),
                  BlocProvider(create: (final context) => UserBloc(repository: UserRepository(widget.dioHttpClient))),
                  BlocProvider(
                    create:
                        (final context) =>
                            VersionBloc(repository: VersionRepository(packageInfo: widget.packageInfo))
                              ..add(const VersionFetched()),
                  ),
                  BlocProvider(
                    create:
                        (final context) => AideVeloBloc(
                          profilRepository: profilRepository,
                          communesRepository: communesRepository,
                          aideVeloRepository: AideVeloRepository(widget.dioHttpClient),
                        ),
                  ),

                  BlocProvider(
                    create:
                        (final context) => GamificationBloc(
                          GamificationRepository(client: widget.dioHttpClient, messageBus: widget.messageBus),
                          widget.authenticationService,
                        )..add(const GamificationSubscriptionRequested()),
                  ),
                  BlocProvider(
                    create:
                        (final context) => EnvironmentalPerformanceQuestionBloc(
                          repository: EnvironmentalPerformanceQuestionRepository(widget.dioHttpClient),
                        ),
                  ),
                  BlocProvider(
                    create:
                        (final context) => EnvironmentalPerformanceBloc(
                          useCase: FetchEnvironmentalPerformance(environmentalPerformanceSummaryRepository),
                        ),
                  ),
                  BlocProvider(
                    create:
                        (final context) =>
                            CarSimulatorResultBloc(carSimulatorRepository: CarSimulatorRepository(widget.dioHttpClient)),
                  ),
                ],
                child: MaterialApp.router(
                  routerConfig: _goRouter,
                  builder:
                      (final context, final child) => UpgradeWidget(
                        navigatorKey: _goRouter.routerDelegate.navigatorKey,
                        child: child ?? const SizedBox.shrink(),
                      ),
                  theme: ThemeData(
                    colorSchemeSeed: DsfrColors.blueFranceSun113,
                    scaffoldBackgroundColor: Colors.white,
                    fontFamily: 'Marianne',
                    package: 'dsfr',
                    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
                  ),
                  locale: locale,
                  localizationsDelegates: const [
                    GlobalCupertinoLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: const [locale],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
