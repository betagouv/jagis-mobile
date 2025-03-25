import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';

class ResetRepository {
  const ResetRepository(this._client);

  final DioHttpClient _client;

  Future<void> reset() async => _client.post(Endpoints.gamificationReset);
}
