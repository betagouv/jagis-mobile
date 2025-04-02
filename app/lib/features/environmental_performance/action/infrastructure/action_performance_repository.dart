import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_detail_item.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_mapper.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:fpdart/fpdart.dart';

class ActionPerformanceRepository {
  const ActionPerformanceRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, EnvironmentalPerformanceDetailItem>> fetch(final ThemeType themeType) async {
    final response = await _client.get(Endpoints.bilanByTheme(themeType.name));
    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération du bilan environnemental'));
    }

    final data = response.data! as Map<String, dynamic>;

    return Right(EnvironmentalPerformanceSummaryMapper.detailItemFromJson(data));
  }
}
