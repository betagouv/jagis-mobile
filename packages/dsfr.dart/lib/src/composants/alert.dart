import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/icons.g.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

enum DsfrAlertSeverity { info, warning, error, success }

class DsfrAlert extends StatelessWidget {
  const DsfrAlert({super.key, required this.severity, this.title, this.description});

  final DsfrAlertSeverity severity;
  final String? title;
  final Widget? description;

  @override
  Widget build(final context) => DecoratedBox(
    decoration: BoxDecoration(color: _color, border: Border.all(color: _color, strokeAlign: BorderSide.strokeAlignOutside)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TODO(erolley): expend in height
        DecoratedBox(
          decoration: BoxDecoration(color: _color),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s2w, horizontal: DsfrSpacings.s1w),
            child: Icon(_icon, size: 24, color: Colors.white),
          ),
        ),
        Expanded(
          child: DecoratedBox(
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(DsfrSpacings.s2w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: DsfrSpacings.s1w,
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
    DsfrAlertSeverity.warning => DsfrIcons.systemFrWarningFill,
    DsfrAlertSeverity.error => DsfrIcons.systemFrErrorFill,
    DsfrAlertSeverity.success => DsfrIcons.systemFrSuccessFill,
  };

  Color get _color => switch (severity) {
    DsfrAlertSeverity.info => DsfrColors.backgroundFlatInfo,
    DsfrAlertSeverity.warning => DsfrColors.warning425,
    DsfrAlertSeverity.error => DsfrColors.error425,
    DsfrAlertSeverity.success => DsfrColors.success425,
  };
}
