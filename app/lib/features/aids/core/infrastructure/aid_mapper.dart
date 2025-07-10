import 'package:app/core/infrastructure/theme_type_mapper.dart';
import 'package:app/features/aids/core/domain/aid.dart';
import 'package:app/features/aids/core/infrastructure/aid_summary_mapper.dart';

abstract final class AidMapper {
  const AidMapper._();

  static Aid fromJson(final Map<String, dynamic> json) {
    final aidSummary = AidSummaryMapper.fromJson(json);

    return Aid(
      id: aidSummary.id,
      themeType: ThemeTypeMapper.convert((json['thematiques'] as List<dynamic>).cast<String>().firstOrNull ?? ''),
      title: aidSummary.title,
      maxAmount: aidSummary.maxAmount,
      isFree: aidSummary.isFree,
      partner: aidSummary.partner,
      scale: aidSummary.scale,
      content: json['contenu'] as String,
      simulatorUrl: aidSummary.simulatorUrl,
      aidUrl: json['url_demande'] as String?,
    );
  }
}
