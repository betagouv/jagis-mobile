import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvCheckbox extends StatefulWidget {
  const FnvCheckbox({super.key, required this.label, required this.value, required this.onChanged});

  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  State<FnvCheckbox> createState() => _FnvCheckboxState();
}

class _FnvCheckboxState extends State<FnvCheckbox> with MaterialStateMixin<FnvCheckbox> {
  @override
  Widget build(final BuildContext context) => DsfrFocusWidget(
    isFocused: isFocused,
    child: InkWell(
      onTap: () => widget.onChanged?.call(!widget.value),
      onHighlightChanged: updateMaterialState(WidgetState.pressed),
      onHover: updateMaterialState(WidgetState.hovered),
      focusColor: Colors.transparent,
      onFocusChange: updateMaterialState(WidgetState.focused),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: widget.value ? DsfrColors.blueFranceSun113 : DsfrColors.grey900)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(DsfrSpacings.s2w),
          child: Row(
            spacing: DsfrSpacings.s1w,
            children: [
              DsfrCheckboxIcon(value: widget.value),
              Flexible(
                child: Text(widget.label, style: DsfrTextStyle.bodyMdCenter(color: DsfrColorDecisions.textLabelGrey(context))),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
