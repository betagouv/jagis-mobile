// ignore_for_file: avoid-single-child-column-or-row

import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvBottomBar extends StatelessWidget {
  const FnvBottomBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(final BuildContext context) => SafeArea(
    left: false,
    top: false,
    right: false,
    child: DecoratedBox(
      decoration: const BoxDecoration(boxShadow: bottomNavigationBarOmbre),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3v, horizontal: DsfrSpacings.s2w),
            child: child,
          ),
        ],
      ),
    ),
  );
}
