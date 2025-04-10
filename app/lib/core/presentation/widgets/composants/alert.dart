import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvAlert extends StatelessWidget {
  const FnvAlert._({super.key, required this.icon, required this.label, required this.color});

  const FnvAlert.error({required final String label, final Key? key})
    : this._(key: key, icon: DsfrIcons.systemFrWarningFill, label: label, color: DsfrColors.error425);

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(final BuildContext context) => Row(
    spacing: DsfrSpacings.s1w,
    children: [
      Icon(icon, size: DsfrSpacings.s2w, color: color),
      Expanded(
        child: Text(label, style: DsfrTextStyle.bodySm(color: color)),
      ),
    ],
  );
}
