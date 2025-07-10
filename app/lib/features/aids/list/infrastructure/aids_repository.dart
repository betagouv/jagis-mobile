import 'dart:async';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/aids/core/domain/aid.dart';
import 'package:app/features/aids/core/domain/aid_list.dart';
import 'package:app/features/aids/core/domain/aid_summary.dart';
import 'package:app/features/aids/core/infrastructure/aid_mapper.dart';
import 'package:app/features/aids/core/infrastructure/aid_summary_mapper.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:fpdart/fpdart.dart';

class AidsRepository {
  const AidsRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, AidList>> fetch() async {
    final response = await _client.get(Endpoints.aids);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des aides'));
    }

    final json = response.data! as Map<String, dynamic>;

    return Right(
      AidList(
        isCovered: json['couverture_aides_ok'] as bool,
        aids: (json['liste_aides'] as List<dynamic>)
            .map((final e) => AidSummaryMapper.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
  }

  Future<Either<Exception, List<AidSummary>>> fetchByTheme({required final ThemeType themeType}) async {
    final url = Uri(path: Endpoints.aids, queryParameters: {'thematique': themeType.name}).toString();
    final response = await _client.get(url);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des aides par thématiques'));
    }

    final json = response.data! as Map<String, dynamic>;

    return Right(
      (json['liste_aides'] as List<dynamic>).map((final e) => AidSummaryMapper.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<Either<Exception, Aid>> fetchById(final String aidId) async {
    final response = await _client.get(Endpoints.aid(aidId));

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des aides'));
    }

    final json = response.data! as Map<String, dynamic>;

    return Right(AidMapper.fromJson(json));
  }
}
