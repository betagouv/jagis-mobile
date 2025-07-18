// ignore_for_file: avoid-slow-collection-methods

import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/environmental_performance/core/presentation/widgets/performance_detail_body.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_data.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/environmental_performance_partner_card.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/full/environmental_performance_tonnes_card.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/full/top_emission_source_item.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/partial/environmental_performance_categories.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app_ds/app_ds.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class BodyFull extends StatelessWidget {
  const BodyFull({super.key, required this.data});

  final EnvironmentalPerformanceFull data;

  @override
  Widget build(final BuildContext context) => ListView(
    padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3w),
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
        child: FnvTitle(title: EnvironmentalPerformanceSummaryL10n.monEmpreinteEcologique),
      ),
      const SizedBox(height: DsfrSpacings.s4w),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingVerticalPage),
        child: EnvironmentalPerformanceTonnesCard(footprint: data.footprintInKgOfCO2ePerYear),
      ),
      const SizedBox(height: DsfrSpacings.s4w),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
        child: Text(
          EnvironmentalPerformanceSummaryL10n.mesPrincipauxPostesDemission,
          style: DsfrTextStyle.headline4(color: DsfrColors.grey50),
        ),
      ),
      const SizedBox(height: DsfrSpacings.s4w),
      ...data.top
          .mapIndexed(
            (final i, final e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: paddingVerticalPage),
              child: TopEmissionSourceItem(
                rank: i + 1,
                label: e.label,
                percentage: e.percentage?.toString() ?? '-',
                emoji: e.emoji,
              ),
            ),
          )
          .separator(const SizedBox(height: DsfrSpacings.s3w)),
      const SizedBox(height: DsfrSpacings.s4w),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
        child: Text(
          EnvironmentalPerformanceSummaryL10n.voirDetailHebdomadaire,
          style: DsfrTextStyle.headline4(color: DsfrColors.grey50),
        ),
      ),
      const SizedBox(height: DsfrSpacings.s4w),
      FnvAccordionsGroup(
        values: data.detail
            .map(
              (final e) => FnvAccordionItem(
                headerBuilder: (final isExpanded) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s3w),
                  child: _DetailHeader(emoji: e.emoji, label: e.label, value: e.footprintInKgOfCO2ePerYear.tonnesRepresentation),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(DsfrSpacings.s3w),
                  child: Column(
                    children: e.subItems
                        .map(
                          (final f) => PerformanceDetailBody(
                            emoji: f.emoji,
                            label: f.label,
                            value: f.footprintInKgOfCO2ePerYear.kilogramsRepresentation,
                            progress: (f.percentage?.toDouble() ?? 0.0) / (e.subItems.first.percentage?.toDouble() ?? 100.0),
                          ),
                        )
                        .separator(const SizedBox(height: DsfrSpacings.s3w))
                        .toList(),
                  ),
                ),
              ),
            )
            .toList(),
      ),
      const SizedBox(height: DsfrSpacings.s4w),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: EnvironmentalPerformanceSummaryL10n.modifier,
                style: DsfrTextStyle.headline4(color: DsfrColors.grey50),
              ),
              TextSpan(
                text: ' ',
                style: DsfrTextStyle.headline4(color: DsfrColors.grey50),
              ),
              TextSpan(
                text: EnvironmentalPerformanceSummaryL10n.vosReponses,
                style: DsfrTextStyle.headline4(color: DsfrColors.blueFranceSun113),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: DsfrSpacings.s1v5),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
        child: Text(
          EnvironmentalPerformanceSummaryL10n.affinerMonEstimationSousTitre,
          style: DsfrTextStyle.bodyMd(color: DsfrColors.grey50),
        ),
      ),
      const SizedBox(height: DsfrSpacings.s3v),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingVerticalPage),
        child: EnvironmentalPerformanceCategories(categories: data.categories),
      ),
      const SizedBox(height: DsfrSpacings.s7w),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
        child: EnvironmentalPerformancePartnerCard(),
      ),
      const SafeArea(child: SizedBox.shrink()),
    ],
  );
}

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({required this.emoji, required this.label, required this.value});

  final String emoji;
  final String label;
  final String value;

  @override
  Widget build(final BuildContext context) {
    const color = Color(0xFF3636A1);

    return Row(
      spacing: DsfrSpacings.s1w,
      children: [
        Text(emoji, style: const DsfrTextStyle.bodyMdMedium(color: DsfrColors.grey50)),
        Expanded(
          child: Text(label, style: const DsfrTextStyle.bodyMdMedium(color: DsfrColors.grey50)),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: value,
                style: const DsfrTextStyle.bodyMdBold(color: color),
              ),
              const TextSpan(text: ' '),
              const TextSpan(text: EnvironmentalPerformanceSummaryL10n.tonnes),
            ],
          ),
          style: const DsfrTextStyle.bodyMd(color: color),
        ),
      ],
    );
  }
}
