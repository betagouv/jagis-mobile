import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/features/services/maif/domain/maif_risk.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MaifRiskWidget extends StatelessWidget {
  const MaifRiskWidget({super.key, required this.risk});

  final MaifRisk risk;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: FnvShadows.card),
    child: Padding(
      padding: const EdgeInsets.all(DsfrSpacings.s2w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DsfrSpacings.s1w,
        children: [
          Text(risk.title, style: const DsfrTextStyle.bodyXlBold(color: DsfrColors.grey50)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _RiskLevel(riskLevel: risk.level),
              Align(
                alignment: Alignment.bottomRight,
                child: FnvImage.asset(
                  switch (risk.type) {
                    RiskType.earthquake => AssetImages.maifSeisme,
                    RiskType.drought || RiskType.clay => AssetImages.maifArgile,
                    RiskType.flood => AssetImages.maifInondation,
                    RiskType.flooding => AssetImages.maifSubmersion,
                    RiskType.storm => AssetImages.maifTempete,
                    RiskType.radon => AssetImages.maifRadon,
                  },
                  width: 48,
                  height: 48,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _RiskLevel extends StatelessWidget {
  const _RiskLevel({required this.riskLevel});

  final RiskLevel riskLevel;

  @override
  Widget build(final BuildContext context) => switch (riskLevel) {
    RiskLevel.unknown => const DsfrTag(
      label: 'Inconnu',
      size: DsfrComponentSize.md,
      backgroundColor: Color(0xFFF1FAF2),
      textColor: Color(0xFF006207),
    ),
    RiskLevel.veryLow => const DsfrTag(
      label: 'Très faible',
      size: DsfrComponentSize.md,
      backgroundColor: Color(0xFFF1FAF2),
      textColor: Color(0xFF006207),
    ),
    RiskLevel.low => const DsfrTag(
      label: 'Faible',
      size: DsfrComponentSize.md,
      backgroundColor: Color(0xFFECFCAC),
      textColor: Color(0xFF424F00),
    ),
    RiskLevel.medium => const DsfrTag(
      label: 'Moyen',
      size: DsfrComponentSize.md,
      backgroundColor: DsfrColors.greenTilleulVerveine950,
      textColor: DsfrColors.warning425,
    ),
    RiskLevel.high => const DsfrTag(
      label: 'Fort',
      size: DsfrComponentSize.md,
      backgroundColor: DsfrColors.warning950,
      textColor: DsfrColors.error425,
    ),
    RiskLevel.veryHigh => const DsfrTag(
      label: 'Très fort',
      size: DsfrComponentSize.md,
      backgroundColor: Color(0xFFFFC0B8),
      textColor: Color(0xFF7B0000),
    ),
  };
}
