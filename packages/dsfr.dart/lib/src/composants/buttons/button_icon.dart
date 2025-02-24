import 'package:dsfr/src/composants/buttons/button.dart';
import 'package:dsfr/src/composants/buttons/raw_button_icon.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

export 'button_icon_location.dart';
export 'button_size.dart';
export 'button_variant.dart';
export 'raw_button.dart';

class DsfrButtonIcon extends StatelessWidget {
  const DsfrButtonIcon({
    super.key,
    required this.icon,
    this.iconColor,
    required this.variant,
    this.foregroundColor,
    required this.size,
    this.onPressed,
  });

  final IconData icon;
  final Color? iconColor;
  final DsfrButtonVariant variant;
  final Color? foregroundColor;
  final DsfrButtonSize size;
  final VoidCallback? onPressed;

  double _getIconSize(final DsfrButtonSize size) {
    switch (size) {
      case DsfrButtonSize.lg:
      case DsfrButtonSize.md:
        return DsfrSpacings.s3w;
      case DsfrButtonSize.sm:
        return DsfrSpacings.s2w;
    }
  }

  @override
  Widget build(final context) {
    Widget child = Icon(icon, size: _getIconSize(size));
    if (iconColor != null) {
      child = IconTheme(data: IconThemeData(color: iconColor), child: child);
    }

    return DsfrRawButtonIcon(variant: variant, size: size, foregroundColor: foregroundColor, onPressed: onPressed, child: child);
  }
}
