// ignore_for_file: avoid-slow-collection-methods

import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/presentation/widgets/composants/alert_info.dart';
import 'package:app/features/profil/home/domain/energy_performance.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_bloc.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_event.dart';
import 'package:app/features/profil/home/presentation/widgets/my_home_title_and_content.dart';
import 'package:app/l10n/l10n.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MyHomeEnergyPerformance extends StatelessWidget {
  const MyHomeEnergyPerformance({super.key, required this.dpe});

  final EnergyPerformance? dpe;

  @override
  Widget build(final BuildContext context) => MyHomeTitleAndContent(
    title: Localisation.consommationsEnergetiques,
    content: Column(
      spacing: DsfrSpacings.s2w,
      children: [
        _FnvDpe(
          initialValue: dpe,
          onChanged: (final value) => context.read<MyHomeBloc>().add(MyHomeDataUpdated(energyPerformance: value)),
        ),
        const FnvAlertInfo(
          label: Localisation.dpeExplication,
          content: FnvMarkdown(data: Localisation.dpeExplicationDetails),
        ),
      ],
    ),
  );
}

class _FnvDpe extends StatefulWidget {
  const _FnvDpe({this.initialValue, required this.onChanged});

  final EnergyPerformance? initialValue;
  final ValueChanged<EnergyPerformance?> onChanged;

  @override
  State<_FnvDpe> createState() => _FnvDpeState();
}

class _FnvDpeState extends State<_FnvDpe> {
  EnergyPerformance? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  void _handleChange(final EnergyPerformance? value) {
    setState(() {
      _value = value;
    });
    widget.onChanged(_value);
  }

  @override
  Widget build(final BuildContext context) {
    final width = MediaQuery.sizeOf(context).width / 100;

    final labels = [
      const _DpeConfig(value: EnergyPerformance.a, name: Localisation.dpeA, color: Color(0xff009c6d)),
      const _DpeConfig(value: EnergyPerformance.b, name: Localisation.dpeB, color: Color(0xff52b153)),
      const _DpeConfig(value: EnergyPerformance.c, name: Localisation.dpeC, color: Color(0xff78bd0b)),
      const _DpeConfig(value: EnergyPerformance.d, name: Localisation.dpeD, color: Color(0xfff4e70f)),
      const _DpeConfig(value: EnergyPerformance.e, name: Localisation.dpeE, color: Color(0xfff0b50f)),
      const _DpeConfig(value: EnergyPerformance.f, name: Localisation.dpeF, color: Color(0xffeb8235)),
      const _DpeConfig(value: EnergyPerformance.g, name: Localisation.dpeG, color: Color(0xffd7221f)),
      const _DpeConfig(value: EnergyPerformance.jeNeSaisPas, name: Localisation.dpeJeNeSaisPas),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s1w,
      children: labels
          .mapIndexed(
            (final index, final e) => _FvnDpeEtiquette(
              label: e.name,
              value: e.value,
              groupValue: _value,
              onChanged: _handleChange,
              color: e.color,
              width: width * ((index + 1) * 10 + 17),
            ),
          )
          .toList(),
    );
  }
}

class _DpeConfig {
  const _DpeConfig({required this.value, required this.name, this.color});

  final String name;
  final EnergyPerformance value;
  final Color? color;
}

class _FvnDpeEtiquette extends StatelessWidget {
  const _FvnDpeEtiquette({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.color,
    required this.width,
  });

  final String label;
  final EnergyPerformance value;
  final EnergyPerformance? groupValue;
  final Color? color;
  final double width;
  final ValueChanged<EnergyPerformance?> onChanged;

  @override
  Widget build(final BuildContext context) {
    Widget customPaint = Padding(
      padding: const EdgeInsets.all(DsfrSpacings.s2w),
      child: Text(label, style: const DsfrTextStyle.bodyMdBold(color: DsfrColors.grey50)),
    );

    if (color != null) {
      customPaint = CustomPaint(
        painter: _Painter(color: color!, isSelected: groupValue == value),
        child: Padding(
          padding: const EdgeInsets.all(DsfrSpacings.s2w),
          child: Text(label, style: const DsfrTextStyle.bodyMdBold(color: Colors.white)),
        ),
      );
    }

    return GestureDetector(
      onTap: () => onChanged(value),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: width,
        child: Row(
          spacing: DsfrSpacings.s1w,
          children: [
            DsfrRadioIcon(key: ValueKey(label), value: value, groupValue: groupValue, size: 24),
            Expanded(child: customPaint),
          ],
        ),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  const _Painter({required this.color, required this.isSelected});

  final Color color;
  final bool isSelected;

  @override
  void paint(final Canvas canvas, final Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width - 20, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width - 20, size.height)
      ..lineTo(0, size.height)
      ..close();

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    if (isSelected) {
      final strokePaint = Paint()
        ..color = DsfrColors.blueFranceSun113
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant final CustomPainter oldDelegate) => false;
}
