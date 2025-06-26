import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvToggleSwitch extends StatelessWidget {
  const FnvToggleSwitch({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    required this.value,
    required this.onChanged,
  });

  final String leftLabel;
  final String rightLabel;
  final bool value;
  final ValueChanged<bool> onChanged;

  void _handleTap(final bool selectLeft) {
    if (value != selectLeft) {
      onChanged(selectLeft);
    }
  }

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: ShapeDecoration(
      shape: StadiumBorder(side: BorderSide(color: DsfrColorDecisions.borderDefaultGrey(context))),
    ),
    child: Padding(
      padding: const EdgeInsets.all(DsfrSpacings.s1w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Semantics(
              selected: value,
              button: true,
              label: 'Sélectionner $leftLabel',
              child: _ToggleSwitchOption(label: leftLabel, isSelected: value, onTap: () => _handleTap(true)),
            ),
          ),
          Flexible(
            child: Semantics(
              selected: !value,
              button: true,
              label: 'Sélectionner $rightLabel',
              child: _ToggleSwitchOption(label: rightLabel, isSelected: !value, onTap: () => _handleTap(false)),
            ),
          ),
        ],
      ),
    ),
  );
}

class _ToggleSwitchOption extends StatefulWidget {
  const _ToggleSwitchOption({required this.label, required this.isSelected, required this.onTap});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_ToggleSwitchOption> createState() => _ToggleSwitchOptionState();
}

class _ToggleSwitchOptionState extends State<_ToggleSwitchOption> with MaterialStateMixin<_ToggleSwitchOption> {
  static const _borderRadius = BorderRadius.all(Radius.circular(50));

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: widget.isSelected
        ? ShapeDecoration(color: DsfrColorDecisions.backgroundActionHighBlueFrance(context), shape: const StadiumBorder())
        : const BoxDecoration(),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        onHighlightChanged: updateMaterialState(WidgetState.pressed),
        onHover: updateMaterialState(WidgetState.hovered),
        focusColor: Colors.transparent,
        borderRadius: _borderRadius,
        onFocusChange: updateMaterialState(WidgetState.focused),
        child: DsfrFocusWidget(
          isFocused: isFocused,
          borderRadius: _borderRadius,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s1v, horizontal: DsfrSpacings.s3v),
            child: Text(
              widget.label,
              style: DsfrTextStyle.bodyMdMedium(
                color: widget.isSelected
                    ? DsfrColorDecisions.textInvertedGrey(context)
                    : DsfrColorDecisions.textTitleBlueFrance(context),
              ).copyWith(height: 24 / 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ),
  );
}
