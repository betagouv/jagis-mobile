import 'package:app/features/environmental_performance/summary/domain/environmental_performance_category.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_data.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_detail_item.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_detail_sub_item.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_level.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_top_item.dart';
import 'package:app/features/environmental_performance/summary/domain/footprint.dart';

abstract final class EnvironmentalPerformanceSummaryMapper {
  const EnvironmentalPerformanceSummaryMapper._();

  static EnvironmentalPerformanceData fromJson(final Map<String, dynamic> json) {
    if (json.containsKey('bilan_complet')) {
      return _fromFullJson(json);
    }

    return _fromPartialJson(json);
  }

  static EnvironmentalPerformanceDetailItem detailItemFromJson(final Map<String, dynamic> json) => _detailItemFromJson(json);

  static EnvironmentalPerformancePartial _fromPartialJson(final Map<String, dynamic> json) {
    final percentageCompletion = (json['pourcentage_completion_totale'] as num).toInt();
    final categories = (json['liens_bilans_thematique'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(_categoryFromJson)
        .toList();

    final partial = json['bilan_approximatif'] as Map<String, dynamic>?;

    return EnvironmentalPerformancePartial(
      partialData: partial == null
          ? null
          : EnvironmentalPerformancePartialLevel(
              performanceOnTransport: _mapLevelFromJson(partial['impact_transport'] as String?),
              performanceOnFood: _mapLevelFromJson(partial['impact_alimentation'] as String?),
              performanceOnHousing: _mapLevelFromJson(partial['impact_logement'] as String?),
              performanceOnConsumption: _mapLevelFromJson(partial['impact_consommation'] as String?),
            ),
      percentageCompletion: percentageCompletion,
      categories: categories,
    );
  }

  static EnvironmentalPerformanceFull _fromFullJson(final Map<String, dynamic> json) {
    final full = json['bilan_complet'] as Map<String, dynamic>;
    final categories = (json['liens_bilans_thematique'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(_categoryFromJson)
        .toList();

    return EnvironmentalPerformanceFull(
      footprintInKgOfCO2ePerYear: Footprint((full['impact_kg_annee'] as num).toDouble()),
      top: (full['top_3'] as List<dynamic>).cast<Map<String, dynamic>>().map(_topItemFromJson).toList(),
      detail: (full['impact_thematique'] as List<dynamic>).cast<Map<String, dynamic>>().map(_detailItemFromJson).toList(),
      categories: categories,
    );
  }

  static EnvironmentalPerformanceLevel? _mapLevelFromJson(final String? type) => switch (type) {
    null => null,
    'faible' => EnvironmentalPerformanceLevel.low,
    'moyen' => EnvironmentalPerformanceLevel.medium,
    'fort' => EnvironmentalPerformanceLevel.high,
    'tres_fort' => EnvironmentalPerformanceLevel.veryHigh,
    _ => throw UnimplementedError('Niveau non implémenté'),
  };

  static EnvironmentalPerformanceTopItem _topItemFromJson(final Map<String, dynamic> json) => EnvironmentalPerformanceTopItem(
    emoji: json['emoji'] as String,
    label: json['label'] as String,
    percentage: (json['pourcentage'] as num?)?.toInt(),
  );

  static EnvironmentalPerformanceDetailItem _detailItemFromJson(final Map<String, dynamic> json) =>
      EnvironmentalPerformanceDetailItem(
        emoji: json['emoji'] as String,
        label: _mapThematique(json['thematique'] as String),
        footprintInKgOfCO2ePerYear: Footprint((json['impact_kg_annee'] as num).toDouble()),
        subItems: (json['details'] as List<dynamic>).cast<Map<String, dynamic>>().map(_detailSubItemFromJson).toList(),
      );

  static EnvironmentalPerformanceDetailSubItem _detailSubItemFromJson(final Map<String, dynamic> json) =>
      EnvironmentalPerformanceDetailSubItem(
        emoji: json['emoji'] as String,
        label: json['label'] as String,
        footprintInKgOfCO2ePerYear: Footprint((json['impact_kg_annee'] as num).toDouble()),
        percentage: (json['pourcentage_categorie'] as num?)?.toInt(),
      );

  static EnvironmentalPerformanceCategory _categoryFromJson(final Map<String, dynamic> json) => EnvironmentalPerformanceCategory(
    id: json['id_enchainement_kyc'] as String,
    imageUrl: json['image_url'] as String,
    percentageCompletion: (json['pourcentage_progression'] as num).toInt(),
    label: _mapThematique(json['thematique'] as String),
    totalNumberQuestions: (json['nombre_total_question'] as num).toInt(),
  );

  static String _mapThematique(final String? type) => switch (type) {
    'alimentation' => 'Alimentation',
    'transport' => 'Transport',
    'consommation' => 'Consommation',
    'logement' => 'Logement',
    'climat' => 'Climat',
    'dechet' => 'Déchets',
    'loisir' => 'Loisir',
    'services_societaux' => 'Services sociétaux',
    _ => 'Découverte',
  };
}
