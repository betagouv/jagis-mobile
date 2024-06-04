// ignore_for_file: do_not_use_environment

import 'dart:ui';

import 'package:app/src/app.dart';
import 'package:app/src/fonctionnalites/aides/infrastructure/adapters/aide_velo_api_adapter.dart';
import 'package:app/src/fonctionnalites/aides/infrastructure/adapters/aides_api_adapter.dart';
import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut_manager.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/api_url.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_api_adapter.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_token_storage.dart';
import 'package:app/src/fonctionnalites/communes/infrastructure/adapters/communes_api_adapter.dart';
import 'package:app/src/fonctionnalites/profil/infrastructure/adapters/profil_api_adapter.dart';
import 'package:app/src/fonctionnalites/utilisateur/infrastructure/adapters/utilisateur_api_adapter.dart';
import 'package:app/src/fonctionnalites/version/infrastructure/adapters/version_adapter.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _registerErrorHandlers();

  const apiUrlKey = 'API_URL';
  const apiUrl = String.fromEnvironment(apiUrlKey);
  if (apiUrl.isEmpty) {
    throw Exception(apiUrlKey);
  }

  final authentificationStatusManager = AuthentificationStatutManager();

  final authentificationTokenStorage = AuthentificationTokenStorage(
    secureStorage: const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
    authentificationStatusManager: authentificationStatusManager,
  );

  await authentificationTokenStorage.initialise();

  final apiClient = AuthentificationApiClient(
    apiUrl: ApiUrl(Uri.parse(apiUrl)),
    authentificationTokenStorage: authentificationTokenStorage,
  );

  final packageInfo = await PackageInfo.fromPlatform();

  runApp(
    App(
      authentificationStatusManager: authentificationStatusManager,
      authentificationRepository: AuthentificationApiAdapter(
        apiClient: apiClient,
      ),
      utilisateurRepository: UtilisateurApiAdapter(apiClient: apiClient),
      aidesRepository: AidesApiAdapter(apiClient: apiClient),
      versionRepository: VersionAdapter(packageInfo: packageInfo),
      communesRepository: CommunesApiAdapter(apiClient: apiClient),
      aideVeloRepository: AideVeloApiAdapter(apiClient: apiClient),
      profilRepository: const ProfilApiAdapter(),
    ),
  );
}

void _registerErrorHandlers() {
  FlutterError.onError = (final details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };

  PlatformDispatcher.instance.onError = (final error, final stack) {
    debugPrint(error.toString());

    return true;
  };

  ErrorWidget.builder = (final details) => Scaffold(
        appBar: AppBar(
          title: const Text('An error occurred'),
          backgroundColor: DsfrColors.redMarianneMain472,
        ),
        body: Center(child: Text(details.toString())),
      );
}
