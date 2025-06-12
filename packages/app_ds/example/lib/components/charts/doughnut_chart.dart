import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(type: FnvDoughnutChart, name: 'Default')
Widget buildDoughnutChartUseCase(final BuildContext context) =>
    const Padding(padding: EdgeInsets.all(16), child: _BasicDoughnutChartExample());

class _BasicDoughnutChartExample extends StatelessWidget {
  const _BasicDoughnutChartExample();

  @override
  Widget build(final BuildContext context) {
    const data = [
      DoughnutChartData(color: Color(0xFFFF9239), emoji: '🔥', label: 'Chauffage', value: 0.59),
      DoughnutChartData(color: Color(0xFF98CCFF), emoji: '🛁', label: 'Eau chaude', value: 0.24),
      DoughnutChartData(color: Color(0xFF77F2B2), emoji: '✳️', label: 'Autres', value: 0.07),
      DoughnutChartData(color: Color(0xFFA8C6E5), emoji: '🍳', label: 'Cuisson', value: 0.03),
      DoughnutChartData(color: Color(0xFFAEF372), emoji: '🧺', label: 'Électroménager', value: 0.03),
      DoughnutChartData(color: Color(0xFFC1BEFF), emoji: '📺', label: 'Multimédia', value: 0.02),
      DoughnutChartData(color: Color(0xFFFFC739), emoji: '💡', label: 'Éclairage', value: 0.02),
    ];

    return const FnvDoughnutChart(
      data: data,
      strokeWidth: 8,
      centerWidget: _DoughnutChartCenterWidget(primaryText: '2823 €', secondaryText: 'consommés', thirdText: 'par an'),
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
