import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class PartnerCard extends StatelessWidget {
  const PartnerCard({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.url,
    required this.logo,
  });

  final String image;
  final String name;
  final String description;
  final String url;
  final String logo;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: cardBoxShadow),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FnvImage.asset(image, alignment: Alignment.topCenter, height: 137, fit: BoxFit.cover),
        Padding(
          padding: const EdgeInsets.all(DsfrSpacings.s3w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                EnvironmentalPerformanceSummaryL10n.proposePar,
                style: DsfrTextStyle.bodySmItalic(color: DsfrColors.blueFranceSun113),
              ),
              Text(name, style: const DsfrTextStyle.headline5()),
              const SizedBox(height: DsfrSpacings.s2w),
              Text(description, style: const DsfrTextStyle.bodySm()),
              const SizedBox(height: DsfrSpacings.s2w),
              DsfrLink.md(
                label: url,
                onTap: () async {
                  await FnvUrlLauncher.launch(url);
                },
              ),
              const SizedBox(height: DsfrSpacings.s3w),
              FnvImage.asset(logo, height: 40, semanticLabel: 'Logo de $name'),
            ],
          ),
        ),
      ],
    ),
  );
}
