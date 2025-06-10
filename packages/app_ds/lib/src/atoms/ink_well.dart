import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvInkWell extends StatefulWidget {
  const FnvInkWell({super.key, this.decoration, this.onTap, this.child});

  final Decoration? decoration;
  final VoidCallback? onTap;
  final Widget? child;

  @override
  State<FnvInkWell> createState() => _FnvInkWellState();
}

class _FnvInkWellState extends State<FnvInkWell> with MaterialStateMixin<FnvInkWell> {
  @override
  Widget build(final BuildContext context) {
    Widget current = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        onHighlightChanged: updateMaterialState(WidgetState.pressed),
        onHover: updateMaterialState(WidgetState.hovered),
        focusColor: Colors.transparent,
        customBorder: widget.decoration is ShapeDecoration ? (widget.decoration! as ShapeDecoration).shape : null,
        onFocusChange: updateMaterialState(WidgetState.focused),
        child: widget.child,
      ),
    );

    if (widget.decoration != null) {
      current = DecoratedBox(decoration: widget.decoration!, child: current);
    }

    return DsfrFocusWidget(isFocused: isFocused, child: current);
  }
}
