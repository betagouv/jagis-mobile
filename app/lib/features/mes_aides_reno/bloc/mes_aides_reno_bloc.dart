import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/mes_aides_reno/bloc/mes_aides_reno_event.dart';
import 'package:app/features/mes_aides_reno/bloc/mes_aides_reno_state.dart';
import 'package:app/features/mes_aides_reno/infrastructure/mes_aides_reno_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesAidesRenoBloc extends Bloc<MesAidesRenoEvent, MesAidesRenoState> {
  MesAidesRenoBloc(final DioHttpClient client) : super(const MesAidesRenoState.init()) {
    on<MesAidesRenoIframeUrlRequested>((final event, final emit) async {
      emit(const MesAidesRenoState.loading());

      final result = await client.get(Endpoints.mesAidesRenoGetIframes);

      if (isResponseSuccessful(result.statusCode)) {
        final json = result.data! as Map<String, dynamic>;
        emit(MesAidesRenoState.success(MesAidesRenoDataMapper.fromJson(json).iframeUrlWhenDone));
      } else {
        emit(
          MesAidesRenoState.failure(
            'Error while fetching data:\n  url: ${Endpoints.mesAidesRenoGetIframes}\n  code: ${result.statusCode ?? 'unknown'}',
          ),
        );
      }
    });

    on<MesAidesRenoSendSituation>((final event, final emit) async {
      final result = await client.post(Endpoints.mesAidesRenoPostSituation, data: event.situation);

      if (isResponseUnsuccessful(result.statusCode)) {
        emit(
          MesAidesRenoState.failure(
            'Error while posting data:\n  url: ${Endpoints.mesAidesRenoPostSituation}\n  code: ${result.statusCode ?? 'unknown'}',
          ),
        );
      }
    });
  }
}
