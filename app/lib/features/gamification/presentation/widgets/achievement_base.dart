import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class AchievementBase extends StatelessWidget {
  const AchievementBase({super.key, required this.icon, required this.backgroundColor, required this.value, required this.onTap});

  final Color backgroundColor;
  final Widget icon;
  final int value;
  final VoidCallback? onTap;

  @override
  Widget build(final BuildContext context) => ExcludeSemantics(
    child: Material(
      color: backgroundColor,
      child: FnvInkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s1v5, horizontal: DsfrSpacings.s1w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: DsfrSpacings.s1v,
            children: [
              Text('$value', style: const DsfrTextStyle.bodySmBold(color: DsfrColors.grey50)),
              ExcludeSemantics(child: icon),
            ],
          ),
        ),
      ),
    ),
  );
}
