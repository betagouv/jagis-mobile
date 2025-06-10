import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvEditTag extends StatelessWidget {
  const FnvEditTag({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: ShapeDecoration(color: color.withAlpha(25), shape: const StadiumBorder()),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s1v, horizontal: DsfrSpacings.s1w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: DsfrSpacings.s1w,
        children: [
          Flexible(
            child: Text(
              label,
              style: DsfrTextStyle.bodySm(color: DsfrColorDecisions.textLabelGrey(context)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(DsfrIcons.designEditLine, size: 18, color: color),
        ],
      ),
    ),
  );
}
