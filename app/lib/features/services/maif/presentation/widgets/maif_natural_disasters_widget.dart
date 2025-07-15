import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MaifNaturalDisastersWidget extends StatelessWidget {
  const MaifNaturalDisastersWidget({super.key, required this.value});

  final int value;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: FnvShadows.card),
    child: Padding(
      padding: const EdgeInsets.all(DsfrSpacings.s2w),
      child: Column(
        children: [
          Text(
            '$value',
            style: const DsfrTextStyle.displayXs(color: DsfrColors.blueFrance125),
            textAlign: TextAlign.center,
          ),
          const Text(
            'arrêtés CATNAT',
            style: DsfrTextStyle.bodyMdBold(color: DsfrColors.grey50),
            textAlign: TextAlign.center,
          ),
          const Text(
            'depuis 1982',
            style: DsfrTextStyle.bodyMd(color: DsfrColors.grey50),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
