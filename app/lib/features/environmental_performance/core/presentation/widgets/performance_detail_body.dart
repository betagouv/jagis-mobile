import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/full/progress_bar.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class PerformanceDetailBody extends StatelessWidget {
  const PerformanceDetailBody({super.key, required this.emoji, required this.label, required this.value, required this.progress});

  final String emoji;
  final String label;
  final String value;
  final double progress;

  @override
  Widget build(final context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(emoji, style: const DsfrTextStyle.bodyMdMedium()),
      const SizedBox(width: DsfrSpacings.s1w),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: DsfrSpacings.s1v5,
          children: [Text(label, style: const DsfrTextStyle.bodyMdMedium()), ProgressBar(value: progress)],
        ),
      ),
      const SizedBox(width: DsfrSpacings.s2w),
      Text.rich(
        TextSpan(
          children: [
            TextSpan(text: value, style: const DsfrTextStyle.bodyMdBold(color: Color(0xff3636A1))),
            const TextSpan(text: ' '),
            const TextSpan(text: EnvironmentalPerformanceSummaryL10n.kg),
          ],
        ),
        style: const DsfrTextStyle.bodyMd(color: Color(0xff3636A1)),
      ),
    ],
  );
}
