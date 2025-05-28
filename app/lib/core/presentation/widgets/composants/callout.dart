import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class FnvCallout extends StatelessWidget {
  const FnvCallout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      color: DsfrColors.grey950,
      border: Border(
        left: BorderSide(color: DsfrColors.blueFranceMain525, width: DsfrSpacings.s1v),
      ),
    ),
    child: Padding(padding: const EdgeInsets.all(DsfrSpacings.s3w), child: child),
  );
}
