import 'package:app/features/services/winter/presentation/bloc/winter_state.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class WinterConsumptionPart extends StatelessWidget {
  const WinterConsumptionPart({super.key, required this.myConsumption});

  final WinterMyConsumption myConsumption;

  @override
  Widget build(final BuildContext context) {
    final data = myConsumption.data;

    final details = data.usageDetails
        .map(
          (final d) => DoughnutChartData(
            color: Color(int.parse('0xFF${d.color}')),
            emoji: d.emoji,
            label: switch (d.type) {
              'heating' => 'Chauffage',
              'airConditioning' => 'Climatisation',
              'other' => 'Autres',
              'appliances' => 'Appareils',
              'multimedia' => 'Multimédia',
              'hotWater' => 'Eau chaude',
              'cooking' => 'Cuisine',
              'lighting' => 'Éclairage',
              'mobility' => 'Mobilité',
              'swimmingPool' => 'Piscine',
              _ => d.type,
            },
            value: d.percent / 100.0,
          ),
        )
        .toList();

    return Column(
      children: [
        FnvDoughnutChart(
          data: details,
          strokeWidth: 8,
          centerWidget: _DoughnutChartCenterWidget(
            primaryText: '${data.totalConsumptionEuros}€',
            secondaryText: 'consommés',
            thirdText: 'par an',
          ),
        ),
        const DsfrDivider(),
        Column(
          children: [
            Row(children: [Text('${data.realizedSavingsEuros}€'), Text('${data.possibleSavingsEuros}€')]),
            FnvProgressBar(
              height: 8,
              trackColor: const Color(0xFFF8EED1),
              progressColor: const Color(0xFFEAB420),
              current: data.realizedSavingsEuros,
              total: data.possibleSavingsEuros,
            ),
          ],
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
