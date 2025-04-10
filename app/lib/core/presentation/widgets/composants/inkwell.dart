// TODO(lsaudon): voir si on peut pas réutiliser ce widget
// ignore_for_file: unused-files, unused-code

import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvInkwell extends StatefulWidget {
  const FnvInkwell({super.key, required this.onTap, required this.color, required this.splashColor, required this.child});

  final GestureTapCallback onTap;
  final Color color;
  final Color splashColor;
  final Widget child;

  @override
  State<FnvInkwell> createState() => _FnvInkwellState();
}

class _FnvInkwellState extends State<FnvInkwell> with MaterialStateMixin<FnvInkwell> {
  @override
  Widget build(final BuildContext context) => DsfrFocusWidget(
    isFocused: isFocused,
    child: Material(
      color: widget.color,
      child: InkWell(
        onTap: widget.onTap,
        onHighlightChanged: updateMaterialState(WidgetState.pressed),
        onHover: updateMaterialState(WidgetState.hovered),
        focusColor: FnvColors.transparent,
        splashColor: widget.splashColor,
        onFocusChange: updateMaterialState(WidgetState.focused),
        child: widget.child,
      ),
    ),
  );
}
