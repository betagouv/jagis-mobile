import 'package:app/features/services/maif/domain/maif_risk.dart';

abstract final class MaifRiskMapper {
  const MaifRiskMapper._();

  static MaifRisk fromJson(final Map<String, dynamic> json) => MaifRisk(
    title: json['titre'] as String,
    level: toLevel(json['niveau_risque'] as String),
    type: toType(json['type_risque'] as String),
  );

  static RiskLevel toLevel(final String level) => switch (level) {
    'tres_faible' => RiskLevel.veryLow,
    'faible' => RiskLevel.low,
    'moyen' => RiskLevel.medium,
    'fort' => RiskLevel.high,
    'tres_fort' => RiskLevel.veryHigh,
    _ => throw Exception('Unknown risk level: $level'),
  };

  static RiskType toType(final String type) => switch (type) {
    'secheresse' => RiskType.drought,
    'inondation' => RiskType.flood,
    'submersion' => RiskType.flooding,
    'tempete' => RiskType.storm,
    'seisme' => RiskType.earthquake,
    'argile' => RiskType.clay,
    'radon' => RiskType.radon,
    _ => throw Exception('Unknown risk type: $type'),
  };
}
