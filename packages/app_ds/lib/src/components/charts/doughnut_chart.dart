import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class DoughnutChartData {
  const DoughnutChartData({required this.color, required this.emoji, required this.label, required this.value});

  final Color color;
  final String emoji;
  final String label;
  final double value;
}

class FnvDoughnutChart extends StatelessWidget {
  const FnvDoughnutChart({required this.data, super.key, required this.strokeWidth, required this.centerWidget});

  final List<DoughnutChartData> data;
  final double strokeWidth;

  /// The widget displayed in the center of the doughnut chart.
  ///
  /// If you want the center widget to take up minimal space, you can set its `mainAxisSize` to `MainAxisSize.min`.
  final Widget centerWidget;

  @override
  Widget build(final BuildContext context) {
    if (data.isEmpty) {
      return const _EmptyDoughnutChart();
    }

    return Column(
      spacing: 60,
      children: [
        SizedBox.square(
          dimension: 208,
          child: _DoughnutChartGraphic(data: data, strokeWidth: strokeWidth, centerWidget: centerWidget),
        ),
        _Grid(
          columnSpacing: 4,
          rowSpacing: 8,
          children: data
              .map(
                (final e) => Row(
                  spacing: 4,
                  children: [
                    SizedBox.square(
                      dimension: 8,
                      child: DecoratedBox(
                        decoration: ShapeDecoration(color: e.color, shape: const CircleBorder()),
                      ),
                    ),
                    Expanded(
                      child: Text(e.label, style: const DsfrTextStyle.bodySm(color: Color(0xFF656565)).copyWith(height: 1.7)),
                    ),
                    Text(
                      '${(e.value * 100).toStringAsFixed(0)}%',
                      style: const DsfrTextStyle.bodyMdBold(color: Color(0xFF272747)).copyWith(height: 1.7),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _EmptyDoughnutChart extends StatelessWidget {
  const _EmptyDoughnutChart();

  @override
  Widget build(final BuildContext context) => const Center(child: Text('No data available'));
}

class _DoughnutChartGraphic extends StatelessWidget {
  const _DoughnutChartGraphic({required this.data, required this.strokeWidth, required this.centerWidget});

  final List<DoughnutChartData> data;
  final double strokeWidth;
  final Widget centerWidget;

  @override
  Widget build(final BuildContext context) => MediaQuery(
    data: const MediaQueryData(textScaler: TextScaler.noScaling),
    child: Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            sections: data
                .map(
                  (final e) => PieChartSectionData(
                    value: e.value,
                    color: e.color,
                    radius: strokeWidth,
                    showTitle: false,
                    badgeWidget: DecoratedBox(
                      decoration: ShapeDecoration(color: e.color, shape: const CircleBorder()),
                      child: SizedBox.square(
                        dimension: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Text(e.emoji, style: const TextStyle(fontSize: 17, height: 1.6), textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    badgePositionPercentageOffset: 4,
                  ),
                )
                .toList(),
            centerSpaceRadius: 208 / 2,
            sectionsSpace: 4,
            startDegreeOffset: 220,
          ),
        ),
        Center(child: centerWidget),
      ],
    ),
  );
}

class _Grid extends StatelessWidget {
  const _Grid({required this.columnSpacing, required this.rowSpacing, required this.children});

  final List<Widget> children;
  final double columnSpacing;
  final double rowSpacing;

  @override
  Widget build(final BuildContext context) {
    final mid = (children.length / 2).ceil();
    final firstRow = children.take(mid).toList();
    final secondRow = children.skip(mid).toList();

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: rowSpacing,
      children: [
        Expanded(
          child: Column(mainAxisSize: MainAxisSize.min, spacing: columnSpacing, children: firstRow),
        ),
        Expanded(
          child: Column(mainAxisSize: MainAxisSize.min, spacing: columnSpacing, children: secondRow),
        ),
      ],
    );
  }
}
