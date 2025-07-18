// ignore_for_file: avoid-slow-collection-methods

import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/presentation/widgets/composants/alert_info.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_bloc.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_event.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_state.dart';
import 'package:app/features/profil/logement/presentation/widgets/mon_logement_titre_et_contenu.dart';
import 'package:app/l10n/l10n.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MonLogementDpe extends StatelessWidget {
  const MonLogementDpe({super.key});

  @override
  Widget build(final BuildContext context) {
    final dpe = context.select<MonLogementBloc, Dpe?>((final bloc) => bloc.state.dpe);

    return MonLogementTitreEtContenu(
      titre: Localisation.consommationsEnergetiques,
      contenu: Column(
        spacing: DsfrSpacings.s2w,
        children: [
          _FnvDpe(
            initialValue: dpe,
            onChanged: (final value) => context.read<MonLogementBloc>().add(MonLogementDpeChange(value)),
          ),
          const FnvAlertInfo(
            label: Localisation.dpeExplication,
            content: FnvMarkdown(data: Localisation.dpeExplicationDetails),
          ),
        ],
      ),
    );
  }
}

class _FnvDpe extends StatefulWidget {
  const _FnvDpe({this.initialValue, required this.onChanged});

  final Dpe? initialValue;
  final ValueChanged<Dpe?> onChanged;

  @override
  State<_FnvDpe> createState() => _FnvDpeState();
}

class _FnvDpeState extends State<_FnvDpe> {
  Dpe? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  void _handleChange(final Dpe? value) {
    setState(() {
      _value = value;
    });
    widget.onChanged(_value);
  }

  @override
  Widget build(final BuildContext context) {
    final width = MediaQuery.sizeOf(context).width / 100;

    final labels = [
      const _DpeConfig(value: Dpe.a, name: Localisation.dpeA, color: Color(0xff009c6d)),
      const _DpeConfig(value: Dpe.b, name: Localisation.dpeB, color: Color(0xff52b153)),
      const _DpeConfig(value: Dpe.c, name: Localisation.dpeC, color: Color(0xff78bd0b)),
      const _DpeConfig(value: Dpe.d, name: Localisation.dpeD, color: Color(0xfff4e70f)),
      const _DpeConfig(value: Dpe.e, name: Localisation.dpeE, color: Color(0xfff0b50f)),
      const _DpeConfig(value: Dpe.f, name: Localisation.dpeF, color: Color(0xffeb8235)),
      const _DpeConfig(value: Dpe.g, name: Localisation.dpeG, color: Color(0xffd7221f)),
      const _DpeConfig(value: Dpe.jeNeSaisPas, name: Localisation.dpeJeNeSaisPas),
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
  final Dpe value;
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
  final Dpe value;
  final Dpe? groupValue;
  final Color? color;
  final double width;
  final ValueChanged<Dpe?> onChanged;

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
