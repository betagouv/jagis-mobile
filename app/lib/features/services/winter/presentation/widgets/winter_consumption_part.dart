import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/features/services/winter/domain/winter_my_consumption_data.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_bloc.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_event.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_state.dart';
import 'package:app/features/services/winter/presentation/pages/winter_actions_page.dart';
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
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s3w,
    children: [
      _Chart(data: myConsumption.data),
      const DsfrDivider(),
      _SavingMoneyWidget(myConsumption: myConsumption),
    ],
  );
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
  const _SavingMoneyWidget({required this.myConsumption});

  final WinterMyConsumption myConsumption;

  @override
  Widget build(final BuildContext context) {
    final data = myConsumption.data;

    return Column(
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
          height: DsfrSpacings.s1w,
          trackColor: const Color(0xFFF8EED1),
          progressColor: const Color(0xFFEAB420),
          current: data.realizedSavingsEuros,
          total: data.possibleSavingsEuros,
        ),
        _ActionsShortcut(numberOfActions: myConsumption.numberOfActions),
        const _RestartButton(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: DsfrSpacings.s1v,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(
                DsfrIcons.systemQuestionFill,
                size: DsfrSpacings.s2w,
                color: DsfrColorDecisions.textMentionGrey(context),
              ),
            ),
            Flexible(
              child: FnvMarkdown(
                data: Localisation.winterPourSupprimerLesDonnees,
                p: DsfrTextStyle.bodySm(color: DsfrColorDecisions.textMentionGrey(context)),
              ),
            ),
          ],
        ),
      ],
    );
  }
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
  const _ActionsShortcut({required this.numberOfActions});

  final int numberOfActions;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: DsfrColors.blueEcume975),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s5w, horizontal: DsfrSpacings.s1w),
      child: Column(
        spacing: DsfrSpacings.s3w,
        children: [
          Column(
            spacing: DsfrSpacings.s1w,
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
            label: Localisation.faitesDesEconomiesBouton(numberOfActions),
            variant: DsfrButtonVariant.primary,
            size: DsfrComponentSize.lg,
            onPressed: () async {
              await GoRouter.of(context).pushNamed(WinterActionsPage.name);
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
