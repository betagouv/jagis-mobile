import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/services/pres_de_chez_vous/domain/pres_de_chez_vous_summary.dart';
import 'package:app/features/services/pres_de_chez_vous/infrastructure/pres_de_chez_vous_summary_mapper.dart';
import 'package:fpdart/fpdart.dart';

class ActionPresDeChezVousRepository {
  const ActionPresDeChezVousRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, List<PresDeChezVousSummary>>> fetch({required final String category}) async {
    final response = await _client.post(
      Endpoints.presDeChezVousSearch,
      data: {'categorie': category, 'nombre_max_resultats': 4, 'rayon_metres': 5000},
    );

    return isResponseUnsuccessful(response.statusCode)
        ? Left(Exception('Erreur lors de la récupération des adresses près de chez vous'))
        : Right(
          ((response.data as Map<String, dynamic>)['resultats'] as List<dynamic>)
              .cast<Map<String, dynamic>>()
              .map(PresDeChezVousSummaryMapper.fromJson)
              .toList(),
        );
  }
}
