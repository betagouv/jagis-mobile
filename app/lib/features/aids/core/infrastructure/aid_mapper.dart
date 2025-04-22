import 'package:app/core/infrastructure/theme_type_mapper.dart';
import 'package:app/features/aids/core/domain/aid.dart';
import 'package:app/features/aids/core/infrastructure/aid_summary_mapper.dart';

abstract final class AidMapper {
  const AidMapper._();

  static Aid fromJson(final Map<String, dynamic> json) {
    final aidSummary = AidSummaryMapper.fromJson(json);

    return Aid(
      id: aidSummary.id,
      title: aidSummary.title,
      maxAmount: aidSummary.maxAmount,
      isFree: aidSummary.isFree,
      partner: aidSummary.partner,
      themeType: ThemeTypeMapper.convert((json['thematiques'] as List<dynamic>).cast<String>().firstOrNull ?? ''),
      scale: aidSummary.scale,
      content: json['contenu'] as String,
      aidUrl: json['url_demande'] as String?,
      simulatorUrl: json['url_simulateur'] as String?,
    );
  }
}
