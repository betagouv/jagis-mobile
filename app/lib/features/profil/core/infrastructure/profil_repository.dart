// ignore_for_file: avoid-long-parameter-list, avoid-nullable-interpolation

import 'dart:convert';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/profil/core/infrastructure/logement_mapper.dart';
import 'package:app/features/profil/home/domain/home.dart';
import 'package:app/features/profil/informations/domain/entities/informations.dart';
import 'package:fpdart/fpdart.dart';

class ProfilRepository {
  const ProfilRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, Informations>> recupererProfil() async {
    final response = await _client.get(Endpoints.profile);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération du profil'));
    }

    final json = response.data as Map<String, dynamic>;

    return Right(
      Informations(
        email: json['email'] as String,
        pseudonym: json['pseudo'] as String?,
        isUserFranceConnect: !(json['is_nom_prenom_modifiable'] as bool),
        prenom: json['prenom'] as String?,
        nom: json['nom'] as String?,
        anneeDeNaissance: json['annee_naissance'] as int?,
        moisDeNaissance: json['mois_naissance'] as int?,
        jourDeNaissance: json['jour_naissance'] as int?,
        codePostal: (json['logement'] as Map<String, dynamic>)['code_postal'] as String?,
        codeInsee: (json['logement'] as Map<String, dynamic>)['code_commune'] as String?,
        nombreDePartsFiscales: (json['nombre_de_parts_fiscales'] as num).toDouble(),
        revenuFiscal: (json['revenu_fiscal'] as num?)?.toInt(),
      ),
    );
  }

  Future<Either<Exception, Unit>> updateInformation({
    required final String? pseudonym,
    required final String? prenom,
    required final String? nom,
    required final int? anneeDeNaissance,
    required final int? moisDeNaissance,
    required final int? jourDeNaissance,
    required final double nombreDePartsFiscales,
    required final int? revenuFiscal,
  }) async {
    final response = await _client.patch(
      Endpoints.profile,
      data: {
        'pseudo': pseudonym,
        'prenom': prenom,
        'nom': nom,
        'annee_naissance': anneeDeNaissance,
        'mois_naissance': moisDeNaissance,
        'jour_naissance': jourDeNaissance,
        'nombre_de_parts_fiscales': nombreDePartsFiscales,
        'revenu_fiscal': revenuFiscal,
      },
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : Left(Exception('Erreur lors de la mise à jour du profil'));
  }

  Future<Home> getHome() async {
    final response = await _client.get(Endpoints.logement);

    if (isResponseUnsuccessful(response.statusCode)) {
      throw Exception('Erreur lors de la récupération du logement');
    }

    final json = response.data as Map<String, dynamic>;

    return LogementMapper.mapLogementFromJson(json);
  }

  Future<Either<Exception, Unit>> supprimerLeCompte() async {
    final response = await _client.delete(Endpoints.utilisateur);

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : Left(Exception('Erreur lors de la suppression du compte'));
  }

  Future<Either<Exception, Unit>> mettreAJourCodePostalEtCommune({
    required final String codePostal,
    required final String codeInsee,
  }) async {
    final response = await _client.patch(
      Endpoints.logement,
      data: jsonEncode({'code_postal': codePostal, 'code_commune': codeInsee}),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : Left(Exception('Erreur lors de la mise à jour du code postal et de la commune'));
  }

  Future<void> updateHome(final Home home) async {
    final response = await _client.patch(Endpoints.logement, data: LogementMapper.mapLogementToJson(home));

    if (isResponseUnsuccessful(response.statusCode)) {
      throw Exception('Erreur lors de la mise à jour du logement');
    }
  }

  Future<void> deleteAddress() async {
    final response = await _client.patch(
      Endpoints.logement,
      data: {'latitude': null, 'longitude': null, 'numero_rue': null, 'rue': null},
    );

    if (isResponseUnsuccessful(response.statusCode)) {
      throw Exception('Erreur lors de la mise à jour du logement');
    }
  }
}
