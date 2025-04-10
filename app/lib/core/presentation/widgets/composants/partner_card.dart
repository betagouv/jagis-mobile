import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class PartnerCard extends StatelessWidget {
  const PartnerCard({
    super.key,
    required this.image,
    this.imageBoxFit = BoxFit.cover,
    required this.name,
    required this.description,
    required this.url,
    this.logo,
  });

  final String image;
  final BoxFit imageBoxFit;
  final String name;
  final String description;
  final String url;
  final String? logo;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: cardShadow),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FnvImage.asset(image, height: 137, fit: imageBoxFit),
        Padding(
          padding: const EdgeInsets.all(DsfrSpacings.s3w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(Localisation.proposePar, style: DsfrTextStyle.bodySmItalic(color: DsfrColors.blueFranceSun113)),
              Text(name, style: const DsfrTextStyle.headline5(color: DsfrColors.grey50)),
              const SizedBox(height: DsfrSpacings.s2w),
              Text(description, style: const DsfrTextStyle.bodySm(color: DsfrColors.grey50)),
              const SizedBox(height: DsfrSpacings.s2w),
              DsfrLink(
                label: url,
                onTap: () async {
                  await FnvUrlLauncher.launch(url);
                },
              ),
              if (logo != null) ...[
                const SizedBox(height: DsfrSpacings.s3w),
                FnvImage.asset(logo!, height: 40, semanticLabel: 'Logo de $name'),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}
