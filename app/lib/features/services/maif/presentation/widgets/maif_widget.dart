import 'package:app/core/address/address_repository.dart';
import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/composants/partner_card.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/bloc/action_bloc.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/services/maif/domain/fetch_risk_info_for_address.dart';
import 'package:app/features/services/maif/domain/maif_risk.dart';
import 'package:app/features/services/maif/presentation/bloc/maif_bloc.dart';
import 'package:app/features/services/maif/presentation/bloc/maif_event.dart';
import 'package:app/features/services/maif/presentation/bloc/maif_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MaifWidget extends StatelessWidget {
  const MaifWidget({super.key, required this.action});

  final ActionSimulator action;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) =>
        MaifBloc(context.read(), context.read(), FetchRiskInfoForAddress(context.read()))..add(const MaifLoadRequested()),
    child: _View(action),
  );
}

class _View extends StatelessWidget {
  const _View(this.action);

  final ActionSimulator action;

  @override
  Widget build(final BuildContext context) => BlocConsumer<MaifBloc, MaifState>(
    builder: (final context, final state) => switch (state) {
      MaifInitial() => const SizedBox.shrink(),
      MaifLoadInProgress() => const Center(child: CircularProgressIndicator()),
      MaifLoadSuccess() => _Success(data: state),
      MaifLoadFailure() => const Center(
        child: Text('Une erreur est survenue lors du chargement des données.', style: TextStyle(color: DsfrColors.error425)),
      ),
    },
    listener: (final context, final state) {
      if (state is MaifLoadSuccess && !action.isDone && state.userAddress.isFull) {
        context.read<ActionBloc>().add(ActionMarkAsDone(id: action.id, type: action.type));
      }
    },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.data});

  final MaifLoadSuccess data;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(Localisation.choisissezUneAdresse, style: DsfrTextStyle.headline3(color: DsfrColors.grey50)),
        const SizedBox(height: DsfrSpacings.s2w),
        FnvAutocomplete(
          initialValue: data.userAddress.isFull ? data.userAddress.label : '',
          displayStringForOption: (final option) => option.label,
          onSearch: (final query) => context.read<AddressRepository>().search(query),
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
            data: Localisation.lesChiffresClesDe(data.searchAddress.city),
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
                  _NaturalDisastersWidget(data.numberOfCatNat),
                  _DroughtWidget(data.droughtPercentage),
                  _FloodWidget(data.floodPercentage),
                ].map((final e) => SizedBox(width: 213, child: e)).toList(),
              ),
            ),
          ),
        ],
        const SizedBox(height: DsfrSpacings.s5w),
        const PartnerCard(
          image: AssetImages.maifImage,
          imageBoxFit: BoxFit.fitHeight,
          name: Localisation.maifNom,
          description: Localisation.maifDescription,
          url: Localisation.maifUrl,
        ),
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
        children: risks.map((final e) => _Risk(risk: e)).toList(),
      ),
    ],
  );
}

class _Risk extends StatelessWidget {
  const _Risk({required this.risk});

  final MaifRisk risk;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: cardShadow),
    child: Padding(
      padding: const EdgeInsets.all(DsfrSpacings.s2w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(risk.title, style: const DsfrTextStyle.bodyXlBold(color: DsfrColors.grey50)),
          const SizedBox(height: DsfrSpacings.s1w),
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

class _NaturalDisastersWidget extends StatelessWidget {
  const _NaturalDisastersWidget(this.value);

  final int value;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: cardShadow),
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

class _DroughtWidget extends StatelessWidget {
  const _DroughtWidget(this.value);

  final int value;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: cardShadow),
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
                'à la sécheresse géotechnique',
                style: DsfrTextStyle.bodyMdBold(color: DsfrColors.grey50),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: DsfrSpacings.s3v, top: DsfrSpacings.s3v),
          child: FnvImage.asset(AssetImages.maifArgile, width: 27, height: 27),
        ),
      ],
    ),
  );
}

class _FloodWidget extends StatelessWidget {
  const _FloodWidget(this.value);

  final int value;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: cardShadow),
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
