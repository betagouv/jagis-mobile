import 'package:app/features/mes_aides_reno/domain/mes_aides_reno_data.dart';

abstract final class MesAidesRenoDataMapper {
  const MesAidesRenoDataMapper._();

  static MesAidesRenoData fromJson(final Map<String, dynamic> json) =>
      MesAidesRenoData(iframeUrl: json['iframe_url'] as String, iframeUrlWhenIsDone: json['iframe_url_deja_faite'] as String);
}
