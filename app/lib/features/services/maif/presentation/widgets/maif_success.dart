import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/presentation/widgets/composants/address/address_search_widget.dart';
import 'package:app/features/services/maif/domain/maif_risk.dart';
import 'package:app/features/services/maif/presentation/bloc/maif_bloc.dart';
import 'package:app/features/services/maif/presentation/bloc/maif_event.dart';
import 'package:app/features/services/maif/presentation/bloc/maif_state.dart';
import 'package:app/features/services/maif/presentation/widgets/maif_drought_widget.dart';
import 'package:app/features/services/maif/presentation/widgets/maif_flood_widget.dart';
import 'package:app/features/services/maif/presentation/widgets/maif_natural_disasters_widget.dart';
import 'package:app/features/services/maif/presentation/widgets/maif_risk_widget.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MaifSuccess extends StatelessWidget {
  const MaifSuccess({super.key, required this.data});

  final MaifLoadSuccess data;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(Localisation.choisissezUneAdresse, style: DsfrTextStyle.headline3(color: DsfrColors.grey50)),
        const SizedBox(height: DsfrSpacings.s2w),
        AddressSearchWidget(
          address: data.userAddress.isFull ? data.userAddress : null,
          onSelected: (final option) => context.read<MaifBloc>().add(MaifAddressChanged(option)),
        ),
        if (data.isLoading) ...[
          const SizedBox(height: DsfrSpacings.s5w),
          const Center(child: FnvLoader()),
        ] else ...[
          if (data.isNewAddress) ...[
            const SizedBox(height: DsfrSpacings.s2w),
            FnvCallout(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: DsfrSpacings.s1w,
                children: [
                  const Text(
                    Localisation.choisirCommeAdressePrincipaleDescription,
                    style: DsfrTextStyle.bodyMd(color: DsfrColors.grey50),
                  ),
                  DsfrButton(
                    label: Localisation.choisirCommeAdressePrincipale,
                    variant: DsfrButtonVariant.secondary,
                    size: DsfrComponentSize.lg,
                    onPressed: () => context.read<MaifBloc>().add(MaifNewAddressChosen(data.searchAddress)),
                  ),
                ],
              ),
            ),
          ],
          if (data.searchAddress.isFull) ...[const SizedBox(height: DsfrSpacings.s3w), _Risks(risks: data.risks)],
          const SizedBox(height: DsfrSpacings.s3w),
          FnvMarkdown(
            data: Localisation.lesChiffresClesDe(data.searchAddress.municipality),
            p: const DsfrTextStyle.headline3(color: DsfrColors.grey50),
            strong: const DsfrTextStyle.headline3(color: DsfrColors.blueFranceSun113),
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            clipBehavior: Clip.none,
            child: IntrinsicHeight(
              child: Row(
                spacing: DsfrSpacings.s2w,
                children: [
                  MaifNaturalDisastersWidget(value: data.numberOfCatNat),
                  MaifDroughtWidget(value: data.droughtPercentage),
                  MaifFloodWidget(value: data.floodPercentage),
                ].map((final e) => SizedBox(width: 213, child: e)).toList(),
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

class _Risks extends StatelessWidget {
  const _Risks({required this.risks});

  final List<MaifRisk> risks;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: DsfrSpacings.s1w,
    children: [
      const Text(Localisation.vosRisques, style: DsfrTextStyle.headline3(color: DsfrColors.grey50)),
      Column(
        spacing: DsfrSpacings.s2w,
        children: risks.map((final e) => MaifRiskWidget(risk: e)).toList(),
      ),
    ],
  );
}
