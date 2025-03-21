// ignore_for_file: deprecated_member_use

import 'package:dsfr/src/composants/buttons/button_variant.dart';
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:flutter/material.dart';

@immutable
class DsfrButtonBackgroundColor extends WidgetStateColor {
  DsfrButtonBackgroundColor({
    required final Color $default,
    required final Color active,
    required final Color hover,
    required final Color disabled,
  }) : _default = $default,
       _active = active,
       _hover = hover,
       _disabled = disabled,
       super($default.value);

  factory DsfrButtonBackgroundColor.fromVariant(final DsfrButtonVariant variant) {
    switch (variant) {
      case DsfrButtonVariant.primary:
        return DsfrButtonBackgroundColor(
          $default: DsfrColors.blueFranceSun113,
          active: DsfrColors.blueFranceSun113Active,
          hover: DsfrColors.blueFranceSun113Hover,
          disabled: DsfrColors.grey925,
        );
      case DsfrButtonVariant.secondary:
      case DsfrButtonVariant.tertiary:
      case DsfrButtonVariant.tertiaryWithoutBorder:
        return DsfrButtonBackgroundColor(
          $default: Colors.transparent,
          active: const Color(0x0A000000),
          hover: const Color(0x14000000),
          disabled: Colors.transparent,
        );
    }
  }

  final Color _default;
  final Color _active;
  final Color _hover;
  final Color _disabled;

  @override
  Color resolve(final Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return _disabled;
    }
    if (states.contains(WidgetState.pressed)) {
      return _active;
    }

    return states.contains(WidgetState.hovered) ? _hover : _default;
  }

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      (other is DsfrButtonBackgroundColor &&
          other._default == _default &&
          other._active == _active &&
          other._hover == _hover &&
          other._disabled == _disabled);

  @override
  int get hashCode => _default.hashCode ^ _active.hashCode ^ _hover.hashCode ^ _disabled.hashCode;
}
