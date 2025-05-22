import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/articles/domain/partner.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class PartnerWidget extends StatelessWidget {
  const PartnerWidget({super.key, required this.partner});

  final Partner partner;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.all(DsfrSpacings.s1w),
    child: Row(
      spacing: DsfrSpacings.s1w,
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border.fromBorderSide(BorderSide(color: Color(0xffb1b1ff))),
          ),
          child: Padding(padding: const EdgeInsets.all(1), child: FnvImage.network(partner.logo, width: 40, height: 40)),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(Localisation.proposePar, style: DsfrTextStyle.bodySmItalic(color: DsfrColors.blueFranceSun113)),
              Text(
                partner.name,
                style: const DsfrTextStyle.bodySm(color: DsfrColors.grey50),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
