import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MaifFloodWidget extends StatelessWidget {
  const MaifFloodWidget({super.key, required this.value});

  final int value;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: FnvShadows.card),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(DsfrSpacings.s2w),
          child: Column(
            children: [
              Text(
                '$value%',
                style: const DsfrTextStyle.displayXs(color: DsfrColors.blueFrance125),
                textAlign: TextAlign.center,
              ),
              const Text(
                'de la surface exposée',
                style: DsfrTextStyle.bodyMd(color: DsfrColors.grey50),
                textAlign: TextAlign.center,
              ),
              const Text(
                'à l’inondation',
                style: DsfrTextStyle.bodyMdBold(color: DsfrColors.grey50),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: DsfrSpacings.s3v, top: DsfrSpacings.s3v),
          child: FnvImage.asset(AssetImages.maifInondation, width: 27, height: 27),
        ),
      ],
    ),
  );
}
