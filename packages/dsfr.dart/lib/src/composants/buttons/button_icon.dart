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
    this.semanticLabel,
    this.iconColor,
    required this.variant,
    this.foregroundColor,
    required this.size,
    this.onPressed,
  });

  final IconData icon;
  final String? semanticLabel;
  final Color? iconColor;
  final DsfrButtonVariant variant;
  final Color? foregroundColor;
  final DsfrComponentSize size;
  final VoidCallback? onPressed;

  double _getIconSize(final DsfrComponentSize size) {
    switch (size) {
      case DsfrComponentSize.lg:
      case DsfrComponentSize.md:
        return DsfrSpacings.s3w;
      case DsfrComponentSize.sm:
        return DsfrSpacings.s2w;
    }
  }

  @override
  Widget build(final BuildContext context) {
    Widget child = Icon(icon, size: _getIconSize(size), semanticLabel: semanticLabel);
    if (iconColor != null) {
      child = IconTheme(data: IconThemeData(color: iconColor), child: child);
    }

    return DsfrRawButtonIcon(variant: variant, size: size, foregroundColor: foregroundColor, onPressed: onPressed, child: child);
  }
}
