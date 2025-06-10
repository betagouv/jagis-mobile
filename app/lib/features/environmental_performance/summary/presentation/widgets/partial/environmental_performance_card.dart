import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_level.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/partial/environmental_performance_card_item.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class EnvironmentalPerformanceCard extends StatelessWidget {
  const EnvironmentalPerformanceCard({super.key, required this.partial});

  final EnvironmentalPerformancePartialLevel partial;

  @override
  Widget build(final BuildContext context) {
    final items = [
      if (partial.performanceOnTransport != null)
        EnvironmentalPerformanceCardItem(
          emoji: EnvironmentalPerformanceSummaryL10n.transportsEmoji,
          label: EnvironmentalPerformanceSummaryL10n.transports,
          level: partial.performanceOnTransport!,
        ),
      if (partial.performanceOnFood != null)
        EnvironmentalPerformanceCardItem(
          emoji: EnvironmentalPerformanceSummaryL10n.alimentationEmoji,
          label: EnvironmentalPerformanceSummaryL10n.alimentation,
          level: partial.performanceOnFood!,
        ),
      if (partial.performanceOnHousing != null)
        EnvironmentalPerformanceCardItem(
          emoji: EnvironmentalPerformanceSummaryL10n.logementEmoji,
          label: EnvironmentalPerformanceSummaryL10n.logement,
          level: partial.performanceOnHousing!,
        ),
      if (partial.performanceOnConsumption != null)
        EnvironmentalPerformanceCardItem(
          emoji: EnvironmentalPerformanceSummaryL10n.consommationEmoji,
          label: EnvironmentalPerformanceSummaryL10n.consommation,
          level: partial.performanceOnConsumption!,
        ),
    ];

    return DecoratedBox(
      decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: FnvShadows.card),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3v, horizontal: DsfrSpacings.s2w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: DsfrSpacings.s2w, children: items),
      ),
    );
  }
}
