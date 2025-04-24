import 'package:dsfr/src/composants/buttons/button.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

export 'button_icon_location.dart';
export 'button_size.dart';
export 'button_variant.dart';
export 'raw_button.dart';

class DsfrButton extends StatelessWidget {
  const DsfrButton({
    super.key,
    required this.label,
    this.icon,
    this.iconLocation = DsfrButtonIconLocation.left,
    this.iconColor,
    required this.variant,
    this.foregroundColor,
    required this.size,
    required this.onPressed,
  });

  final IconData? icon;
  final String label;
  final DsfrButtonIconLocation iconLocation;
  final Color? iconColor;
  final DsfrButtonVariant variant;
  final Color? foregroundColor;
  final DsfrComponentSize size;
  final VoidCallback? onPressed;

  double _getIconSize(final DsfrComponentSize size) {
    switch (size) {
      case DsfrComponentSize.lg:
        return DsfrSpacings.s3w;
      case DsfrComponentSize.md:
      case DsfrComponentSize.sm:
        return DsfrSpacings.s2w;
    }
  }

  @override
  Widget build(final BuildContext context) {
    Widget child = Text(label, overflow: TextOverflow.ellipsis);
    if (icon != null) {
      final buttonIcon = Icon(icon, size: _getIconSize(size));
      var children = <Widget>[buttonIcon, const SizedBox(width: DsfrSpacings.s1w), Flexible(child: child)];
      if (iconLocation == DsfrButtonIconLocation.right) {
        children = children.reversed.toList();
      }

      child = Row(mainAxisSize: MainAxisSize.min, children: children);
    }

    if (iconColor != null) {
      child = IconTheme(data: IconThemeData(color: iconColor), child: child);
    }

    return DsfrRawButton(
      variant: variant,
      size: size,
      foregroundColor: foregroundColor,
      onPressed: onPressed,
      child: Center(child: child),
    );
  }
}
