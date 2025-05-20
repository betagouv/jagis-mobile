import 'dart:async';
import 'dart:convert';

import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/error/domain/api_erreur.dart';
import 'package:app/core/error/infrastructure/api_erreur_helpers.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/features/authentification/core/domain/information_de_code.dart';
import 'package:app/features/authentification/france_connect/domain/open_id.dart';
import 'package:fpdart/fpdart.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AuthentificationRepository {
  const AuthentificationRepository(this._client, this._authenticationService);

  final DioHttpClient _client;
  final AuthenticationService _authenticationService;

  Future<Either<ApiErreur, Unit>> loginRequested(final String email) async {
    final response = await _client.post(Endpoints.magicLinkSend, data: jsonEncode({'email': email, 'origin': 'mobile'}));

    if (isResponseUnsuccessful(response.statusCode)) {
      return handleError(jsonEncode(response.data), defaultMessage: 'Erreur lors de la connexion');
    }

    return const Right(unit);
  }

  Future<Either<ApiErreur, Unit>> accountCreationRequested(final String email) async {
    final response = await _client.post(
      Endpoints.magicLinkSend,
      data: jsonEncode({'email': email, 'source_inscription': 'mobile', 'origin': 'mobile'}),
    );

    return isResponseUnsuccessful(response.statusCode)
        ? handleError(jsonEncode(response.data), defaultMessage: 'Erreur lors de la création du compte')
        : const Right(unit);
  }

  Future<Either<ApiErreur, Unit>> validationRequested(final InformationDeCode informationDeConnexion) async {
    final response = await _client.post(
      Endpoints.magicLinkLogin,
      data: jsonEncode({'code': informationDeConnexion.code, 'email': informationDeConnexion.email}),
    );

    if (isResponseUnsuccessful(response.statusCode)) {
      return handleError(jsonEncode(response.data), defaultMessage: 'Erreur lors de la validation du code');
    }

    final json = response.data as Map<String, dynamic>;
    final token = json['token'] as String;

    await _authenticationService.login(token);

    return const Right(unit);
  }

  void franceConnectStep1() =>
      unawaited(FnvUrlLauncher.launch('${_client.baseUrl}/login_france_connect', mode: LaunchMode.externalApplication));

  Future<Either<ApiErreur, Unit>> franceConnectStep2({required final OpenId openId}) async {
    final response = await _client.post(
      Endpoints.franceConnectStep2,
      data: {'oidc_code': openId.code, 'oidc_state': openId.state},
    );

    if (isResponseUnsuccessful(response.statusCode)) {
      return handleError(jsonEncode(response.data), defaultMessage: 'Erreur lors de la connexion via FranceConnect');
    }

    final json = response.data as Map<String, dynamic>;
    final token = json['token'] as String;

    await _authenticationService.login(token);

    return const Right(unit);
  }

  Future<Either<Exception, Unit>> logoutRequested() async {
    final response = await _client.post(Endpoints.logout);
    if (isResponseSuccessful(response.statusCode) && response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;
      final callbackUrl = data['france_connect_logout_url'] as String?;
      if (callbackUrl != null) {
        unawaited(FnvUrlLauncher.launch(callbackUrl, mode: LaunchMode.externalApplication));
      }
    }

    await _authenticationService.logout();

    return const Right(unit);
  }
}
