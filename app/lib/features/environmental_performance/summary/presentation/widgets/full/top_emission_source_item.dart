// ignore_for_file: prefer-spacing

import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class TopEmissionSourceItem extends StatelessWidget {
  const TopEmissionSourceItem({
    super.key,
    required this.rank,
    required this.label,
    required this.percentage,
    required this.emoji,
  });

  final int rank;
  final String label;
  final String percentage;
  final String emoji;

  @override
  Widget build(final BuildContext context) => Row(
    children: [
      Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: DsfrSpacings.s1w,
          children: [
            Text('$rank.', style: const DsfrTextStyle.bodyXlMedium(color: DsfrColors.grey50)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: DsfrSpacings.s1v5,
                children: [
                  Text(label, style: const DsfrTextStyle.bodyXlBold(color: DsfrColors.grey50)),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '$percentage%',
                          style: const DsfrTextStyle.bodyLgBold(color: Color(0xFFDF1451)),
                        ),
                        const TextSpan(
                          text: ' de vos émissions',
                          style: DsfrTextStyle.bodyLg(color: DsfrColors.grey50),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: DsfrSpacings.s1w),
      Text(emoji, style: const DsfrTextStyle(fontSize: 30)),
      const SizedBox(width: DsfrSpacings.s2w),
    ],
  );
}
