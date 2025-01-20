import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/seasonal_fruits_and_vegetables/domain/seasonal_fruits_and_vegetables_month.dart';
import 'package:fpdart/fpdart.dart';

class SeasonalFruitsAndVegetablesRepository {
  const SeasonalFruitsAndVegetablesRepository({
    required final DioHttpClient client,
  }) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, List<SeasonalFruitsAndVegetablesMonth>>>
      fetch() async {
    final response = await _client.get(
      Endpoints.seasonalFruitsAndVegetables,
    );

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(
        Exception(
          'Erreur lors de la récupération les mois des fruits et légumes',
        ),
      );
    }

    final json = response.data as List<dynamic>;

    return Right(
      json
          .map(
            (final e) => SeasonalFruitsAndVegetablesMonthMapper.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}

abstract final class SeasonalFruitsAndVegetablesMonthMapper {
  static SeasonalFruitsAndVegetablesMonth fromJson(
    final Map<String, dynamic> json,
  ) =>
      SeasonalFruitsAndVegetablesMonth(
        code: json['code'] as String,
        label: json['label'] as String,
        value: json['is_default'] as bool,
      );
}
