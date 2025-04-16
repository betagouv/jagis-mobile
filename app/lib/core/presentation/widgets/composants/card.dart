import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class FnvCard extends StatefulWidget {
  const FnvCard({super.key, required this.child, this.onTap, this.borderColor});

  final Widget child;
  final GestureTapCallback? onTap;
  final Color? borderColor;

  @override
  State<FnvCard> createState() => _FnvCardState();
}

class _FnvCardState extends State<FnvCard> with MaterialStateMixin<FnvCard> {
  @override
  Widget build(final BuildContext context) => DsfrFocusWidget(
    isFocused: isFocused,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: FnvColors.carteFond,
        border: widget.borderColor == null ? null : Border.all(color: widget.borderColor!, width: DsfrSpacings.s0v5),
        boxShadow: cardBoxShadow,
      ),
      child: Material(
        color: FnvColors.transparent,
        child:
            widget.onTap == null
                ? widget.child
                : InkWell(
                  onTap: widget.onTap,
                  onHighlightChanged: updateMaterialState(WidgetState.pressed),
                  onHover: updateMaterialState(WidgetState.hovered),
                  focusColor: FnvColors.transparent,
                  onFocusChange: updateMaterialState(WidgetState.focused),
                  child: widget.child,
                ),
      ),
    ),
  );
}
