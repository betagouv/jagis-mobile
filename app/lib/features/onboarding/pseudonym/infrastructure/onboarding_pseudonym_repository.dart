import 'dart:convert';

import 'package:app/core/error/infrastructure/api_erreur_helpers.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:fpdart/fpdart.dart';

final class OnboardingPseudonymRepository {
  const OnboardingPseudonymRepository({required final DioHttpClient client}) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, Unit>> savePseudonymAndBirthdate(final String pseudonym, final DateTime? birthdate) async {
    final response = await _client.patch(
      Endpoints.profile,
      data: jsonEncode({
        'pseudo': pseudonym,
        if (birthdate != null) ...{
          'annee_naissance': birthdate.year,
          'mois_naissance': birthdate.month,
          'jour_naissance': birthdate.day,
        },
      }),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : handleError(jsonEncode(response.data), defaultMessage: 'Erreur lors de la mise à jour du pseudonyme');
  }
}
