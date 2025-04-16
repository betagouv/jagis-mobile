import 'dart:async';

import 'package:dsfr/src/atoms/focus_widget.dart';
import 'package:dsfr/src/composants/buttons/button.dart';
import 'package:dsfr/src/composants/buttons/button_background_color.dart';
import 'package:dsfr/src/composants/buttons/button_border.dart';
import 'package:dsfr/src/composants/buttons/button_foreground_color.dart';
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrRawButton extends StatefulWidget {
  const DsfrRawButton({
    super.key,
    required this.variant,
    required this.size,
    this.foregroundColor,
    this.borderRadius,
    this.onPressed,
    required this.child,
  });

  final Widget child;
  final DsfrButtonVariant variant;
  final Color? foregroundColor;
  final DsfrComponentSize size;
  final BorderRadius? borderRadius;
  final VoidCallback? onPressed;

  @override
  State<DsfrRawButton> createState() => _DsfrRawButtonState();
}

class _DsfrRawButtonState extends State<DsfrRawButton> with MaterialStateMixin<DsfrRawButton> {
  late final double _minHeight;
  late final EdgeInsetsGeometry _padding;
  late final TextStyle _textStyle;
  late final DsfrButtonBackgroundColor _backgroundColor;
  late final DsfrButtonForegroundColor _foregroundColor;
  late final DsfrButtonBorder _border;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _backgroundColor = DsfrButtonBackgroundColor.fromVariant(widget.variant);
    _foregroundColor =
        widget.foregroundColor == null
            ? DsfrButtonForegroundColor.fromVariant(widget.variant)
            : DsfrButtonForegroundColor($default: widget.foregroundColor!, disabled: DsfrColors.grey625);
    _border =
        widget.foregroundColor == null
            ? DsfrButtonBorder.fromVariant(widget.variant)
            : DsfrButtonBorder(
              $default: Border.fromBorderSide(BorderSide(color: widget.foregroundColor!)),
              disabled: const Border.fromBorderSide(BorderSide(color: DsfrColors.grey925)),
            );
    _padding = _getPadding(widget.size);
    _textStyle = _getTextStyle(widget.size);
    _minHeight = _getMinHeight(widget.size);
    setMaterialState(WidgetState.disabled, widget.onPressed == null);
  }

  EdgeInsetsGeometry _getPadding(final DsfrComponentSize size) => switch (size) {
    DsfrComponentSize.lg => const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
    DsfrComponentSize.md => const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    DsfrComponentSize.sm => const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
  };

  TextStyle _getTextStyle(final DsfrComponentSize size) => switch (size) {
    DsfrComponentSize.lg => const DsfrTextStyle.bodyLgMedium(height: 1),
    DsfrComponentSize.md => const DsfrTextStyle.bodyMdMedium(height: 1),
    DsfrComponentSize.sm => const DsfrTextStyle.bodySmMedium(height: 1),
  };

  double _getMinHeight(final DsfrComponentSize size) => switch (size) {
    DsfrComponentSize.lg => DsfrSpacings.s6w,
    DsfrComponentSize.md => DsfrSpacings.s5w,
    DsfrComponentSize.sm => DsfrSpacings.s4w,
  };

  @override
  void didUpdateWidget(final DsfrRawButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    setMaterialState(WidgetState.disabled, widget.onPressed == null);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final textColor = _foregroundColor.resolve(materialStates);

    return DsfrFocusWidget(
      isFocused: isFocused,
      child: Semantics(
        enabled: widget.onPressed != null,
        button: true,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: _minHeight),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: _backgroundColor.resolve(materialStates),
              border: _border.resolve(materialStates),
              borderRadius: widget.borderRadius,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap:
                    widget.onPressed == null
                        ? null
                        : () {
                          if (_timer?.isActive ?? false) {
                            return;
                          }
                          widget.onPressed!();
                          _timer = Timer(const Duration(milliseconds: 500), () {});
                        },
                onHighlightChanged: updateMaterialState(WidgetState.pressed),
                onHover: updateMaterialState(WidgetState.hovered),
                focusColor: Colors.transparent,
                canRequestFocus: widget.onPressed != null,
                onFocusChange: updateMaterialState(WidgetState.focused),
                child: Padding(
                  padding: _padding,
                  child: Center(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: IconTheme(
                      data: IconThemeData(color: textColor),
                      child: DefaultTextStyle(style: _textStyle.copyWith(color: textColor), child: widget.child),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
