import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_data.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_mapper.dart';
import 'package:fpdart/fpdart.dart';

class EnvironmentalPerformanceSummaryRepository {
  const EnvironmentalPerformanceSummaryRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, EnvironmentalPerformanceData>> fetch() async {
    final response = await _client.get(Endpoints.bilan);
    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération du bilan environnemental'));
    }

    final data = response.data! as Map<String, dynamic>;

    return Right(EnvironmentalPerformanceSummaryMapper.fromJson(data));
  }
}
