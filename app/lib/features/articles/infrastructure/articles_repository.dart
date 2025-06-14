import 'dart:convert';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/articles/infrastructure/article_mapper.dart';
import 'package:fpdart/fpdart.dart';

class ArticlesRepository {
  const ArticlesRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, Article>> recupererArticle(final String id) async {
    final responseApi = await _client.get(Endpoints.article(id));

    return isResponseUnsuccessful(responseApi.statusCode)
        ? Left(Exception("Erreur lors de la récupération de l'article"))
        : Right(ArticleMapper.fromJson(json: responseApi.data as Map<String, dynamic>));
  }

  Future<Either<Exception, Unit>> addToFavorites(final String id) async {
    final response = await _client.post(Endpoints.events, data: jsonEncode({'content_id': id, 'type': 'article_favoris'}));

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : Left(Exception("Erreur lors de l'ajout de l'article aux favoris"));
  }

  Future<Either<Exception, Unit>> removeToFavorites(final String id) async {
    final response = await _client.post(Endpoints.events, data: jsonEncode({'content_id': id, 'type': 'article_non_favoris'}));

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : Left(Exception("Erreur lors du retrait de l'article aux favoris"));
  }

  Future<Either<Exception, Unit>> share(final String id) async {
    final response = await _client.post(Endpoints.articleShare(id));

    return isResponseSuccessful(response.statusCode) ? const Right(unit) : Left(Exception("Erreur lors du partage de l'article"));
  }
}
