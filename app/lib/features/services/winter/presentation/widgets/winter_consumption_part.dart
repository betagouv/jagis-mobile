import 'package:app/features/actions/presentation/pages/actions_page.dart';
import 'package:app/features/services/winter/domain/winter_my_consumption_data.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_bloc.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_event.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class WinterConsumptionPart extends StatelessWidget {
  const WinterConsumptionPart({super.key, required this.myConsumption});

  final WinterMyConsumption myConsumption;

  @override
  Widget build(final BuildContext context) {
    final data = myConsumption.data;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s3w,
      children: [
        _Chart(data: data),
        const DsfrDivider(),
        _SavingMoneyWidget(data: data),
      ],
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({required this.data});

  final WinterMyConsumptionData data;

  @override
  Widget build(final BuildContext context) {
    final details = data.usageDetails
        .map(
          (final d) => DoughnutChartData(
            color: Color(int.parse('0xFF${d.color}')),
            emoji: d.emoji,
            label: switch (d.type) {
              'other' => Localisation.winterTypeAutres,
              'appliances' => Localisation.winterTypeAppareils,
              'heating' => Localisation.winterTypeChauffage,
              'airConditioning' => Localisation.winterTypeClimatisation,
              'cooking' => Localisation.winterTypeCuisine,
              'hotWater' => Localisation.winterTypeEauChaude,
              'lighting' => Localisation.winterTypeEclairage,
              'mobility' => Localisation.winterTypeMobilite,
              'multimedia' => Localisation.winterTypeMultimedia,
              'swimmingPool' => Localisation.winterTypePiscine,
              _ => d.type,
            },
            value: d.percent / 100.0,
          ),
        )
        .toList();

    return Column(
      children: [
        const SizedBox(height: DsfrSpacings.s3w),
        FnvDoughnutChart(
          data: details,
          strokeWidth: 8,
          centerWidget: _DoughnutChartCenterWidget(
            primaryText: '${data.totalConsumptionEuros}€',
            secondaryText: Localisation.consommes,
            thirdText: Localisation.parAn,
          ),
        ),
      ],
    );
  }
}

class _DoughnutChartCenterWidget extends StatelessWidget {
  const _DoughnutChartCenterWidget({required this.primaryText, required this.secondaryText, required this.thirdText});

  final String primaryText;
  final String secondaryText;
  final String thirdText;

  @override
  Widget build(final BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(primaryText, style: DsfrTextStyle.displayXs(color: DsfrColorDecisions.textTitleGrey(context))),
      Text(secondaryText, style: DsfrTextStyle.bodySm(color: DsfrColorDecisions.textLabelGrey(context))),
      Text(thirdText, style: DsfrTextStyle.bodyXs(color: DsfrColorDecisions.textDisabledGrey(context))),
    ],
  );
}

class _SavingMoneyWidget extends StatelessWidget {
  const _SavingMoneyWidget({required this.data});

  final WinterMyConsumptionData data;

  @override
  Widget build(final BuildContext context) => Column(
    spacing: DsfrSpacings.s3w,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: _SavingColumn(amount: '${data.realizedSavingsEuros}€', label: Localisation.economises),
          ),
          Expanded(
            child: _SavingColumn(
              amount: '${data.possibleSavingsEuros}€',
              label: Localisation.economiesPossibles,
              highlighted: true,
            ),
          ),
        ],
      ),
      FnvProgressBar(
        height: 8,
        trackColor: const Color(0xFFF8EED1),
        progressColor: const Color(0xFFEAB420),
        current: data.realizedSavingsEuros,
        total: data.possibleSavingsEuros,
      ),
      const _ActionsShortcut(),
      const _RestartButton(),
    ],
  );
}

class _SavingColumn extends StatelessWidget {
  const _SavingColumn({required this.amount, required this.label, this.highlighted = false});

  final String amount;
  final String label;
  final bool highlighted;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (highlighted)
        _SavingAmountDisplay(amount: amount)
      else
        Text(amount, style: const DsfrTextStyle.displayXs(color: DsfrColors.blueFrance125)),
      if (highlighted) const SizedBox(height: DsfrSpacings.s1v5),
      Text(label, style: DsfrTextStyle.bodyMd(color: DsfrColorDecisions.textLabelGrey(context))),
      const Text(Localisation.parAn, style: DsfrTextStyle.bodyMd(color: DsfrColors.greyMain525)),
    ],
  );
}

class _SavingAmountDisplay extends StatelessWidget {
  const _SavingAmountDisplay({required this.amount});

  final String amount;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: DsfrColors.yellowTournesol950, borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: Text(amount, style: const DsfrTextStyle.headline2(color: DsfrColors.warning200).copyWith(height: 1)),
    ),
  );
}

class _ActionsShortcut extends StatelessWidget {
  const _ActionsShortcut();

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: DsfrColors.blueEcume975),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s5w, horizontal: DsfrSpacings.s1w),
      child: Column(
        spacing: 24,
        children: [
          Column(
            spacing: 8,
            children: [
              Text(
                Localisation.faitesDesEconomies,
                style: DsfrTextStyle.headline3(color: DsfrColorDecisions.textTitleGrey(context)),
              ),
              Text(
                Localisation.faitesDesEconomiesDetails,
                style: DsfrTextStyle.bodyMd(color: DsfrColorDecisions.textMentionGrey(context)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          DsfrButton(
            label: Localisation.faitesDesEconomiesBouton(1),
            variant: DsfrButtonVariant.primary,
            size: DsfrComponentSize.lg,
            onPressed: () async {
              await GoRouter.of(context).pushNamed(ActionsPage.name);
            },
          ),
        ],
      ),
    ),
  );
}

class _RestartButton extends StatelessWidget {
  const _RestartButton();

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s2w,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DsfrSpacings.s1w,
        children: [
          Text(Localisation.winterParametres, style: DsfrTextStyle.headline2(color: DsfrColorDecisions.textTitleGrey(context))),
          Text(
            Localisation.winterParametresDetails,
            style: DsfrTextStyle.bodyMd(color: DsfrColorDecisions.textLabelGrey(context)),
          ),
        ],
      ),
      DsfrButton(
        label: Localisation.recommencer,
        icon: DsfrIcons.systemRefreshLine,
        variant: DsfrButtonVariant.secondary,
        size: DsfrComponentSize.lg,
        onPressed: () => context.read<WinterBloc>().add(const WinterRestart()),
      ),
    ],
  );
}
