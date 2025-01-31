import 'dart:async';

import 'package:app/app/router/app_router.dart';
import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/authentication/infrastructure/authentication_injection.dart';
import 'package:app/core/authentication/infrastructure/authentication_redirection.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/core/notifications/domain/notification_data.dart';
import 'package:app/core/notifications/domain/notification_page_type.dart';
import 'package:app/core/notifications/infrastructure/notification_repository.dart';
import 'package:app/core/notifications/infrastructure/notification_service.dart';
import 'package:app/features/actions/detail/infrastructure/action_repository.dart';
import 'package:app/features/actions/list/domain/actions_port.dart';
import 'package:app/features/actions/list/infrastructure/actions_adapter.dart';
import 'package:app/features/actions/section/infrastructure/actions_repository.dart';
import 'package:app/features/actions/section/presentation/bloc/actions_bloc.dart';
import 'package:app/features/articles/domain/articles_port.dart';
import 'package:app/features/articles/infrastructure/articles_api_adapter.dart';
import 'package:app/features/articles/presentation/pages/article_page.dart';
import 'package:app/features/assistances/core/presentation/bloc/aides_accueil_bloc.dart';
import 'package:app/features/assistances/item/presentation/bloc/aide_bloc.dart';
import 'package:app/features/assistances/list/infrastructure/assistances_repository.dart';
import 'package:app/features/assistances/list/presentation/bloc/aides_disclaimer/aides_disclaimer_cubit.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_repository.dart';
import 'package:app/features/bibliotheque/infrastructure/bibliotheque_repository.dart';
import 'package:app/features/bibliotheque/presentation/bloc/bibliotheque_bloc.dart';
import 'package:app/features/communes/domain/communes_port.dart';
import 'package:app/features/environmental_performance/questions/infrastructure/environment_performance_question_repository.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_bloc.dart';
import 'package:app/features/environmental_performance/summary/application/fetch_environmental_performance.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_repository.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/gamification/infrastructure/gamification_api_adapter.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_event.dart';
import 'package:app/features/home/presentation/cubit/home_disclaimer_cubit.dart';
import 'package:app/features/know_your_customer/core/domain/mieux_vous_connaitre_port.dart';
import 'package:app/features/know_your_customer/list/infrastructure/know_your_customers_repository.dart';
import 'package:app/features/mission/actions/infrastructure/mission_actions_repository.dart';
import 'package:app/features/mission/home/infrastructure/mission_home_repository.dart';
import 'package:app/features/mission/home/presentation/bloc/mission_home_bloc.dart';
import 'package:app/features/mission/mission/infrastructure/mission_repository.dart';
import 'package:app/features/mission/mission/presentation/pages/mission_page.dart';
import 'package:app/features/profil/core/domain/profil_port.dart';
import 'package:app/features/questions/first_name/domain/first_name_port.dart';
import 'package:app/features/quiz/domain/quiz_port.dart';
import 'package:app/features/quiz/presentation/pages/quiz_page.dart';
import 'package:app/features/recommandations/infrastructure/recommandations_api_adapter.dart';
import 'package:app/features/recommandations/presentation/bloc/recommandations_bloc.dart';
import 'package:app/features/seasonal_fruits_and_vegetables/infrastructure/seasonal_fruits_and_vegetables_repository.dart';
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
    required this.quizPort,
    required this.communesPort,
    required this.firstNamePort,
    required this.profilPort,
    required this.knowYourCustomersRepository,
    required this.mieuxVousConnaitrePort,
  });

  final Clock clock;
  final Tracker tracker;
  final MessageBus messageBus;
  final DioHttpClient dioHttpClient;
  final PackageInfo packageInfo;
  final NotificationService notificationService;
  final AuthenticationService authenticationService;
  final QuizPort quizPort;
  final CommunesPort communesPort;
  final FirstNamePort firstNamePort;
  final ProfilPort profilPort;
  final KnowYourCustomersRepository knowYourCustomersRepository;
  final MieuxVousConnaitrePort mieuxVousConnaitrePort;

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
    _messageOpenedSubscription =
        widget.notificationService.onMessageOpenedApp.listen(
      (final event) async {
        widget.tracker.trackNotificationOpened(
          '${event.pageType} - ${event.pageId}',
        );

        return _handleNotification(goRouter: _goRouter, data: event);
      },
    );
  }

  Future<void> _handleNotification({
    required final GoRouter goRouter,
    required final NotificationData data,
  }) async {
    switch (data.pageType) {
      case NotificationPageType.quiz:
        await _handleQuizNotification(goRouter: goRouter, pageId: data.pageId);
      case NotificationPageType.article:
        await _handleArticleNotification(
          goRouter: goRouter,
          pageId: data.pageId,
        );
      case NotificationPageType.mission:
        await _handleMissionNotification(
          goRouter: goRouter,
          pageId: data.pageId,
        );
    }
  }

  Future<void> _handleQuizNotification({
    required final GoRouter goRouter,
    required final String pageId,
  }) async {
    await goRouter.pushNamed(QuizPage.name, pathParameters: {'id': pageId});
  }

  Future<void> _handleArticleNotification({
    required final GoRouter goRouter,
    required final String pageId,
  }) async {
    await goRouter.pushNamed(
      ArticlePage.name,
      pathParameters: {'id': pageId},
    );
  }

  Future<void> _handleMissionNotification({
    required final GoRouter goRouter,
    required final String pageId,
  }) async {
    await goRouter.pushNamed(
      MissionPage.name,
      pathParameters: {'mission': pageId, 'thematique': 'thematique'},
    );
  }

  @override
  void dispose() {
    unawaited(_messageOpenedSubscription.cancel());
    _goRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(final context) {
    const locale = Locale('fr', 'FR');

    final upgradeBloc = UpgradeBloc();
    widget.dioHttpClient.add(UpgradeInterceptor(upgradeBloc));

    final gamificationRepository = GamificationApiAdapter(
      client: widget.dioHttpClient,
      messageBus: widget.messageBus,
    );

    final assistancesRepository =
        AssistancesRepository(client: widget.dioHttpClient);

    return InheritedGoRouter(
      goRouter: _goRouter,
      child: AuthenticationInjection(
        authenticationService: widget.authenticationService,
        child: AuthenticationRedirection(
          child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider.value(value: widget.notificationService),
              RepositoryProvider.value(value: widget.tracker),
              RepositoryProvider.value(value: widget.clock),
              RepositoryProvider.value(value: assistancesRepository),
              RepositoryProvider.value(value: widget.quizPort),
              RepositoryProvider.value(value: widget.profilPort),
              RepositoryProvider.value(value: widget.communesPort),
              RepositoryProvider.value(
                value: widget.knowYourCustomersRepository,
              ),
              RepositoryProvider.value(value: widget.mieuxVousConnaitrePort),
              RepositoryProvider.value(value: widget.firstNamePort),
              RepositoryProvider(
                create: (final context) => AuthentificationRepository(
                  client: widget.dioHttpClient,
                  authenticationService: widget.authenticationService,
                ),
              ),
              RepositoryProvider(
                create: (final context) => ThemeRepository(
                  client: widget.dioHttpClient,
                ),
              ),
              RepositoryProvider<ArticlesPort>(
                create: (final context) =>
                    ArticlesApiAdapter(client: widget.dioHttpClient),
              ),
              RepositoryProvider<ActionsPort>(
                create: (final context) =>
                    ActionsAdapter(client: widget.dioHttpClient),
              ),
              RepositoryProvider.value(value: gamificationRepository),
              RepositoryProvider(
                create: (final context) => ActionRepository(
                  client: widget.dioHttpClient,
                  messageBus: widget.messageBus,
                ),
              ),
              RepositoryProvider(
                create: (final context) =>
                    MissionRepository(client: widget.dioHttpClient),
              ),
              RepositoryProvider(
                create: (final context) =>
                    MissionActionsRepository(client: widget.dioHttpClient),
              ),
              RepositoryProvider(
                create: (final context) => NotificationRepository(
                  client: widget.dioHttpClient,
                  notificationService: widget.notificationService,
                ),
              ),
              RepositoryProvider(
                create: (final context) =>
                    SeasonalFruitsAndVegetablesRepository(
                  client: widget.dioHttpClient,
                ),
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: upgradeBloc),
                BlocProvider(create: (final context) => HomeDisclaimerCubit()),
                BlocProvider(create: (final context) => AidesDisclaimerCubit()),
                BlocProvider(
                  create: (final context) => UserBloc(
                    repository: UserRepository(client: widget.dioHttpClient),
                  ),
                ),
                BlocProvider(
                  create: (final context) => AidesAccueilBloc(
                    assistancesRepository: assistancesRepository,
                  ),
                ),
                BlocProvider(
                  create: (final context) => MissionHomeBloc(
                    repository:
                        MissionHomeRepository(client: widget.dioHttpClient),
                  ),
                ),
                BlocProvider(
                  create: (final context) => ActionsBloc(
                    repository: ActionsRepository(
                      client: widget.dioHttpClient,
                    ),
                  ),
                ),
                BlocProvider(create: (final context) => AideBloc()),
                BlocProvider(
                  create: (final context) => VersionBloc(
                    repository:
                        VersionRepository(packageInfo: widget.packageInfo),
                  )..add(const VersionFetched()),
                ),
                BlocProvider(
                  create: (final context) => AideVeloBloc(
                    profilPort: widget.profilPort,
                    communesPort: widget.communesPort,
                    aideVeloRepository: AideVeloRepository(
                      client: widget.dioHttpClient,
                    ),
                  ),
                ),
                BlocProvider(
                  create: (final context) => RecommandationsBloc(
                    recommandationsPort:
                        RecommandationsApiAdapter(client: widget.dioHttpClient),
                  ),
                ),
                BlocProvider(
                  create: (final context) => GamificationBloc(
                    repository: gamificationRepository,
                    authenticationService: widget.authenticationService,
                  )..add(const GamificationAbonnementDemande()),
                ),
                BlocProvider(
                  create: (final context) => BibliothequeBloc(
                    repository: BibliothequeRepository(
                      client: widget.dioHttpClient,
                    ),
                  ),
                ),
                BlocProvider(
                  create: (final context) =>
                      EnvironmentalPerformanceQuestionBloc(
                    repository: EnvironmentalPerformanceQuestionRepository(
                      client: widget.dioHttpClient,
                    ),
                  ),
                ),
                BlocProvider(
                  create: (final context) => EnvironmentalPerformanceBloc(
                    useCase: FetchEnvironmentalPerformance(
                      EnvironmentalPerformanceSummaryRepository(
                        client: widget.dioHttpClient,
                      ),
                    ),
                  ),
                ),
              ],
              child: MaterialApp.router(
                routerConfig: _goRouter,
                builder: (final context, final child) => UpgradeWidget(
                  navigatorKey: _goRouter.routerDelegate.navigatorKey,
                  child: child ?? const SizedBox(),
                ),
                theme: ThemeData(
                  colorSchemeSeed: DsfrColors.blueFranceSun113,
                  scaffoldBackgroundColor: Colors.white,
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
    );
  }
}
