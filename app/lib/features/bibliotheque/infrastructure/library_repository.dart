import 'dart:async';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/bibliotheque/domain/library.dart';
import 'package:app/features/bibliotheque/infrastructure/library_mapper.dart';
import 'package:fpdart/fpdart.dart';

class LibraryRepository {
  const LibraryRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, Library>> fetch({
    required final List<String>? themes,
    required final String? title,
    required final bool? isFavorites,
    required final bool? areAlreadyRead,
  }) async {
    final map = {
      if (themes != null && themes.isNotEmpty) 'filtre_thematiques': themes.join(','),
      if (title != null && title.isNotEmpty) 'titre': title,
      if (isFavorites != null && isFavorites)
        'include': 'favoris'
      else if (areAlreadyRead != null && areAlreadyRead)
        'include': 'lu',
    };

    final uri = Uri(path: Endpoints.bibliotheque, queryParameters: map.isNotEmpty ? map : null);

    final response = await _client.get(uri.toString());

    return isResponseUnsuccessful(response.statusCode)
        ? Left(Exception('Erreur lors de la récupération de la bibliothèque'))
        : Right(LibraryMapper.fromJson(response.data as Map<String, dynamic>));
  }
}
