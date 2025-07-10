import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/theme/core/domain/theme_info.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/core/infrastructure/theme_data_mapper.dart';
import 'package:fpdart/fpdart.dart';

class ThemeRepository {
  const ThemeRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, ThemeInfo>> fetchTheme({required final ThemeType themeType}) async {
    final path = Endpoints.theme(themeType.name);
    final response = await _client.get(path);

    return isResponseSuccessful(response.statusCode)
        ? Right(ThemeDataMapper.fromJson(response.data as Map<String, dynamic>))
        : Left(Exception('Erreur lors de la récupération du thème'));
  }

  Future<Either<Exception, Unit>> confirmCustomization({required final ThemeType themeType}) async {
    final response = await _client.post(Endpoints.confirmCustomization(themeType.name));

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : Left(Exception('Erreur lors de la confirmation de la personnalisation'));
  }

  Future<Either<Exception, Unit>> resetCustomization({required final ThemeType themeType}) async {
    final response = await _client.post(Endpoints.resetCustomization(themeType.name));

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : Left(Exception('Erreur lors de la confirmation de la personnalisation'));
  }
}
