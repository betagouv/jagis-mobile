import 'dart:convert';

import 'package:app/core/error/infrastructure/api_erreur_helpers.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/onboarding/pseudonym/domain/pseudonym.dart';
import 'package:fpdart/fpdart.dart';

final class OnboardingPseudonymRepository {
  const OnboardingPseudonymRepository({required final DioHttpClient client}) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, Unit>> addPseudonym(final Pseudonym pseudonym) async {
    final response = await _client.patch(Endpoints.profile, data: jsonEncode({'pseudo': pseudonym.value}));

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : handleError(jsonEncode(response.data), defaultMessage: 'Erreur lors de la mise à jour du pseudonyme');
  }
}
