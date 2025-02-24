import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class FnvTag extends StatefulWidget {
  const FnvTag({super.key, required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final GestureTapCallback onTap;

  @override
  State<FnvTag> createState() => _FnvTagState();
}

class _FnvTagState extends State<FnvTag> with MaterialStateMixin<FnvTag> {
  @override
  Widget build(final context) {
    const blue = DsfrColors.blueFranceSun113;
    const borderRadius = BorderRadius.all(Radius.circular(100));

    return DsfrFocusWidget(
      isFocused: isFocused,
      borderRadius: borderRadius,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.selected ? blue : null,
          border: const Border.fromBorderSide(BorderSide(color: blue)),
          borderRadius: borderRadius,
        ),
        child: InkWell(
          onTap: widget.onTap,
          onHighlightChanged: updateMaterialState(WidgetState.pressed),
          onHover: updateMaterialState(WidgetState.hovered),
          focusColor: FnvColors.transparent,
          borderRadius: borderRadius,
          onFocusChange: updateMaterialState(WidgetState.focused),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s1v5, horizontal: DsfrSpacings.s3v),
            child: Text(widget.label, style: DsfrTextStyle.bodySmMedium(color: widget.selected ? Colors.white : blue)),
          ),
        ),
      ),
    );
  }
}
