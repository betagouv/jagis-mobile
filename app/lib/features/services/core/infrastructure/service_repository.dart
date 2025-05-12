import 'package:app/core/address/address.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/services/core/bloc/service_state.dart';
import 'package:fpdart/fpdart.dart';

typedef ServiceResult<T> = T Function(Map<String, dynamic> jsonObject);

class ServiceRepository {
  const ServiceRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, ServiceCategories>> fetchCategories(final String service) async {
    final response = await _client.get(Endpoints.serviceCategories(service));

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des catégories'));
    }

    return Right(
      ServiceCategories(
        elements:
            (response.data as List<dynamic>)
                .cast<Map<String, dynamic>>()
                .map(
                  (final json) => ServiceCategory(
                    code: json['code'] as String,
                    label: json['label'] as String,
                    isDefault: json['is_default'] as bool,
                  ),
                )
                .toList(),
      ),
    );
  }

  Future<Either<Exception, List<T>>> fetch<T extends Object>({
    required final String service,
    required final String category,
    required final int limit,
    required final ServiceResult<T> fromJson,
    required final Address? address,
  }) async {
    final data = {
      'categorie': category,
      'nombre_max_resultats': limit,
      'rayon_metres': 5000,
      if (address != null) ...{'latitude': address.latitude, 'longitude': address.longitude},
    };

    final response = await _client.post(Endpoints.serviceSearch(service), data: data);

    return isResponseUnsuccessful(response.statusCode)
        ? Left(Exception('Erreur lors de la récupération des résultats du service'))
        : Right(
          ((response.data as Map<String, dynamic>)['resultats'] as List<dynamic>)
              .cast<Map<String, dynamic>>()
              .map(fromJson)
              .toList(),
        );
  }

  Future<Either<Exception, T>> fetchOne<T extends Object>({
    required final String service,
    required final String id,
    required final ServiceResult<T> fromJson,
  }) async {
    final response = await _client.get(Endpoints.serviceDetail(service, id));

    return isResponseUnsuccessful(response.statusCode)
        ? Left(Exception('Erreur lors de la récupération des détails du service'))
        : Right(fromJson(response.data as Map<String, dynamic>));
  }
}
