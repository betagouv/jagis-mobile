import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/services/pdcn/domain/pdcn_summary.dart';
import 'package:app/features/services/pdcn/infrastructure/pdcn_summary_mapper.dart';
import 'package:fpdart/fpdart.dart';

class PdcnRepository {
  const PdcnRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, List<PdcnSummary>>> fetch({required final String category, required final int limit}) async {
    final response = await _client.post(
      Endpoints.serviceSearch('proximite'),
      data: {'categorie': category, 'nombre_max_resultats': limit, 'rayon_metres': 5000},
    );

    return isResponseUnsuccessful(response.statusCode)
        ? Left(Exception('Erreur lors de la récupération des adresses près de chez vous'))
        : Right(
            ((response.data as Map<String, dynamic>)['resultats'] as List<dynamic>)
                .cast<Map<String, dynamic>>()
                .map(PdcnSummaryMapper.fromJson)
                .toList(),
          );
  }
}
