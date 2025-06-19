import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvToggleSwitch extends StatefulWidget {
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

  @override
  State<FnvToggleSwitch> createState() => _FnvToggleSwitchState();
}

class _FnvToggleSwitchState extends State<FnvToggleSwitch> {
  var _value = false;
  bool get _isLeft => _value;
  bool get _isRight => !_value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  void _handleTap(final bool selectLeft) {
    if (_value != selectLeft) {
      setState(() {
        _value = selectLeft;
      });
      widget.onChanged(selectLeft);
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
              selected: _isLeft,
              button: true,
              label: 'Sélectionner ${widget.leftLabel}',
              child: _ToggleSwitchOption(label: widget.leftLabel, isSelected: _isLeft, onTap: () => _handleTap(true)),
            ),
          ),
          Flexible(
            child: Semantics(
              selected: _isRight,
              button: true,
              label: 'Sélectionner ${widget.rightLabel}',
              child: _ToggleSwitchOption(label: widget.rightLabel, isSelected: _isRight, onTap: () => _handleTap(false)),
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
