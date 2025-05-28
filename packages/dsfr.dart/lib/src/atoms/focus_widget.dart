import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrFocusWidget extends StatelessWidget {
  const DsfrFocusWidget({super.key, required this.isFocused, this.borderRadius, required this.child});

  final bool isFocused;
  final BorderRadiusGeometry? borderRadius;
  final Widget child;

  @override
  Widget build(final BuildContext context) {
    if (!isFocused) {
      return child;
    }

    const marginAroundChild = DsfrSpacings.s0v5;

    return Stack(
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          left: -marginAroundChild,
          top: -marginAroundChild,
          right: -marginAroundChild,
          bottom: -marginAroundChild,
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: const Border.fromBorderSide(
                  BorderSide(color: DsfrColors.focus525, width: marginAroundChild, strokeAlign: BorderSide.strokeAlignOutside),
                ),
                borderRadius: borderRadius?.add(const BorderRadius.all(Radius.circular(marginAroundChild))),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
