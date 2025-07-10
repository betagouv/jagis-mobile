import 'package:app/core/helpers/size.dart';
import 'package:app/features/aids/core/domain/aid_summary.dart';
import 'package:app/features/aids/core/presentation/widgets/aid_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class ThemeAidsHorizontalList extends StatelessWidget {
  const ThemeAidsHorizontalList({super.key, required this.aids});

  final List<AidSummary> aids;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s3w,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
        child: Text('Mes aides', style: DsfrTextStyle.headline3(color: DsfrColorDecisions.textTitleGrey(context))),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
        clipBehavior: Clip.none,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: DsfrSpacings.s2w,
            children: aids
                .map((final aid) => AidSummaryCard(aidSummary: aid, width: screenWidth(context, percentage: 0.85)))
                .toList(),
          ),
        ),
      ),
    ],
  );
}
