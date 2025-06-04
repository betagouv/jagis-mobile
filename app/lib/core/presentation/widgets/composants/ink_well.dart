import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvInkWell extends StatefulWidget {
  const FnvInkWell({super.key, this.onTap, this.child});

  final VoidCallback? onTap;
  final Widget? child;

  @override
  State<FnvInkWell> createState() => _FnvInkWellState();
}

class _FnvInkWellState extends State<FnvInkWell> with MaterialStateMixin<FnvInkWell> {
  @override
  Widget build(final BuildContext context) => DsfrFocusWidget(
    isFocused: isFocused,
    child: InkWell(
      onTap: widget.onTap,
      onHighlightChanged: updateMaterialState(WidgetState.pressed),
      onHover: updateMaterialState(WidgetState.hovered),
      focusColor: Colors.transparent,
      onFocusChange: updateMaterialState(WidgetState.focused),
      child: widget.child,
    ),
  );
}
