import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/domain/service_item.dart';
import 'package:app/features/theme/core/domain/theme_info.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/core/infrastructure/mission_liste_mapper.dart';
import 'package:app/features/theme/core/infrastructure/service_item_mapper.dart';
import 'package:app/features/theme/core/infrastructure/theme_data_mapper.dart';
import 'package:fpdart/fpdart.dart';

class ThemeRepository {
  const ThemeRepository({required final DioHttpClient client}) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, ThemeInfo>> fetchTheme({required final ThemeType themeType}) async {
    final response = await _client.get(Endpoints.theme(themeType.name));

    return isResponseSuccessful(response.statusCode)
        ? Right(ThemeDataMapper.fromJson(response.data as Map<String, dynamic>))
        : Left(Exception('Erreur lors de la récupération du thème'));
  }

  Future<Either<Exception, List<MissionListe>>> getMissions(final ThemeType themeType) async {
    final response = await _client.get(Endpoints.missionsRecommandeesParThematique(themeType.name));

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des missions'));
    }
    final json = response.data as List<dynamic>;

    return Right(json.map((final e) => MissionListeMapper.fromJson(e as Map<String, dynamic>)).toList());
  }

  Future<Either<Exception, List<ServiceItem>>> getServices(final ThemeType themeType) async {
    final response = await _client.get(Endpoints.servicesParThematique(themeType.name));

    return isResponseSuccessful(response.statusCode)
        ? Right((response.data as List<dynamic>).cast<Map<String, dynamic>>().map(ServiceItemMapper.fromJson).toList())
        : Left(Exception('Erreur lors de la récupération des services'));
  }

  Future<Either<Exception, Unit>> confirmCustomization({required final ThemeType themeType}) async {
    final response = await _client.post(Endpoints.confirmCustomization(themeType.name));

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : Left(Exception('Erreur lors de la confirmation de la personnalisation'));
  }
}
