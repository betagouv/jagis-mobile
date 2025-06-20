import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class AchievementBase extends StatelessWidget {
  const AchievementBase({super.key, required this.value, required this.icon, required this.backgroundColor});

  final int value;
  final Color backgroundColor;
  final Widget icon;

  @override
  Widget build(final BuildContext context) => ExcludeSemantics(
    child: ColoredBox(
      color: backgroundColor,
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
  );
}
