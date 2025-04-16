import 'package:app/core/helpers/size.dart';
import 'package:app/features/aids/core/domain/aid_summary.dart';
import 'package:app/features/aids/core/presentation/widgets/aid_summary_card.dart';
import 'package:app/l10n/l10n.dart';
import 'package:collection/collection.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class ActionAidsView extends StatelessWidget {
  const ActionAidsView({super.key, required this.aidSummaries});

  final List<AidSummary> aidSummaries;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.all(DsfrSpacings.s2w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s2w,
      children: [
        const Text(Localisation.aidesEtBonsPlans, style: DsfrTextStyle.headline3()),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          clipBehavior: Clip.none,
          child: IntrinsicHeight(
            child: Row(
              spacing: DsfrSpacings.s2w,
              children:
                  aidSummaries
                      .sorted((final a, final b) => a.scale == null ? 0 : a.scale!.compareTo(b.scale))
                      .map((final a) => AidSummaryCard(aidSummary: a, width: screenWidth(context, percentage: 0.8)))
                      .toList(),
            ),
          ),
        ),
        const SizedBox(height: DsfrSpacings.s4w),
      ],
    ),
  );
}
