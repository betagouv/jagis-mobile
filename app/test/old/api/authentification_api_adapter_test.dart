import 'dart:io';

import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/authentication/domain/authentication_status.dart';
import 'package:app/core/authentication/domain/user_id.dart';
import 'package:app/core/authentication/infrastructure/authentication_storage.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/authentification/core/domain/information_de_code.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_repository.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../features/helper/flutter_secure_storage_fake.dart';
import '../../helpers/authentication_service_setup.dart';
import '../../helpers/dio_mock.dart';
import 'constants.dart';

void main() {
  const email = 'test@example.com';

  test("connexionDemandee envoie une requête POST à l'API avec les informations de connexion", () async {
    // Arrange.
    final dio = DioMock()..postM(Endpoints.magicLinkSend);

    final repository = AuthentificationRepository(
      DioHttpClient(dio: dio, authenticationService: authenticationService),
      authenticationService,
    );

    // Act.
    await repository.loginRequested(email);

    // Assert.
    verify(() => dio.post<dynamic>(Endpoints.magicLinkSend, data: '{"email":"$email","origin":"mobile"}'));
  });

  test(
    "validationCodeConnexionDemandee ajoute le token et l'utisateurId dans le secure storage et modifie le statut a connecté",
    () async {
      final dio =
          DioMock()
            ..postM(Endpoints.magicLinkSend, statusCode: HttpStatus.created)
            ..postM(
              Endpoints.magicLinkLogin,
              statusCode: HttpStatus.created,
              responseData: {
                'token': token,
                'utilisateur': {'id': 'user123'},
              },
            );

      final flutterSecureStorage = FlutterSecureStorageFake();

      final authenticationService = AuthenticationService(
        authenticationStorage: AuthenticationStorage(flutterSecureStorage),
        clock: Clock.fixed(DateTime(1992)),
      );
      final repository = AuthentificationRepository(
        DioHttpClient(dio: dio, authenticationService: authenticationService),
        authenticationService,
      );
      await repository.loginRequested(email);

      // Act.
      await repository.validationRequested(const InformationDeCode(email: 'test@example.com', code: '123456'));

      // Assert.
      final actual = await flutterSecureStorage.readAll();
      expect(actual, equals({'token': token}));
      expect(authenticationService.status, equals(const Authenticated(UserId(utilisateurId))));

      verify(() => dio.post<dynamic>(Endpoints.magicLinkLogin, data: '{"code":"123456","email":"test@example.com"}'));
    },
  );

  test(
    "deconnexionDemandee supprime le token et l'utisateurId dans le secure storage et modifie le statut a pas connecté",
    () async {
      // Arrange.
      final flutterSecureStorageMock = FlutterSecureStorageFake();

      final dioMock = DioMock()..postM(Endpoints.logout);
      final repository = AuthentificationRepository(
        DioHttpClient(dio: dioMock, authenticationService: authenticationService),
        authenticationService,
      );

      // Act.
      await repository.logoutRequested();

      // Assert.
      expect(await flutterSecureStorageMock.readAll(), equals(<String, dynamic>{}));
      expect(authenticationService.status, equals(const Unauthenticated()));
    },
  );

  test('creationDeCompteDemandee', () async {
    final dio =
        DioMock()..postM(
          Endpoints.magicLinkSend,
          statusCode: HttpStatus.created,
          responseData: '''
{
  "email": "$email",
}''',
        );

    final repository = AuthentificationRepository(
      DioHttpClient(dio: dio, authenticationService: authenticationService),
      authenticationService,
    );

    await repository.accountCreationRequested(email);

    verify(
      () =>
          dio.post<dynamic>(Endpoints.magicLinkSend, data: '{"email":"$email","source_inscription":"mobile","origin":"mobile"}'),
    );
  });

  test('validationDemandee', () async {
    final dio =
        DioMock()..postM(
          Endpoints.magicLinkLogin,
          statusCode: HttpStatus.created,
          responseData: {
            'token': token,
            'utilisateur': {'id': utilisateurId},
          },
        );

    final flutterSecureStorageMock = FlutterSecureStorageFake();
    final authenticationService = AuthenticationService(
      authenticationStorage: AuthenticationStorage(flutterSecureStorageMock),
      clock: Clock.fixed(DateTime(1992)),
    );
    final repository = AuthentificationRepository(
      DioHttpClient(dio: dio, authenticationService: authenticationService),
      authenticationService,
    );

    await repository.validationRequested(const InformationDeCode(email: 'test@example.com', code: '123456'));

    // Assert.
    expect(await flutterSecureStorageMock.readAll(), equals({'token': token}));
    expect(authenticationService.status, equals(const Authenticated(UserId(utilisateurId))));

    verify(() => dio.post<dynamic>(Endpoints.magicLinkLogin, data: '{"code":"123456","email":"test@example.com"}'));
  });
}
