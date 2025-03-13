import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

enum DsfrAlertSeverity { info /* , warning, error, success */ }

class DsfrAlert extends StatelessWidget {
  const DsfrAlert({super.key, required this.severity, this.title, this.description});

  final DsfrAlertSeverity severity;
  final String? title;
  final Widget? description;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(border: Border.all(color: _color, strokeAlign: BorderSide.strokeAlignOutside), color: _color),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //expend in height
        DecoratedBox(
          decoration: BoxDecoration(color: _color),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s1w, vertical: DsfrSpacings.s2w),
            child: Icon(_icon, size: 24, color: Colors.white),
          ),
        ),
        Expanded(
          child: DecoratedBox(
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(DsfrSpacings.s2w),
              child: Column(
                spacing: DsfrSpacings.s1w,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null) Text(title!, style: const DsfrTextStyle.headline3()),
                  if (description != null) description!,
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  IconData get _icon => switch (severity) {
    DsfrAlertSeverity.info => DsfrIcons.systemFrInfoFill,
    // case DsfrAlertSeverity.warning:
    //   return Icons.warning;
    // case DsfrAlertSeverity.error:
    //   return Icons.error;
    // case DsfrAlertSeverity.success:
    //   return Icons.check;
  };

  Color get _color => switch (severity) {
    DsfrAlertSeverity.info => DsfrColors.backgroundFlatInfo,
    // case DsfrAlertSeverity.warning:
    //   return Colors.orange.shade100;
    // case DsfrAlertSeverity.error:
    //   return Colors.red.shade100;
    // case DsfrAlertSeverity.success:
    //   return Colors.green.shade100;
  };
}
