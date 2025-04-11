import 'package:dsfr/src/composants/radios/radio.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

enum DsfrRadioButtonSetMode { row, column }

class DsfrRadioButtonGroupHeadless<T> extends StatefulWidget {
  const DsfrRadioButtonGroupHeadless({
    super.key,
    this.mode = DsfrRadioButtonSetMode.row,
    required this.values,
    required this.onChanged,
    this.initialValue,
    this.isEnabled = true,
  });

  final DsfrRadioButtonSetMode mode;
  final Map<T, String> values;
  final T? initialValue;
  final ValueChanged<T?> onChanged;
  final bool isEnabled;

  @override
  State<DsfrRadioButtonGroupHeadless<T>> createState() => _DsfrRadioButtonGroupHeadlessState<T>();
}

class _DsfrRadioButtonGroupHeadlessState<T> extends State<DsfrRadioButtonGroupHeadless<T>> {
  T? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  void _handleChange(final T? value) => setState(() {
    _value = value;
    widget.onChanged(_value);
  });

  @override
  Widget build(final context) {
    final children = widget.values.entries
        .map(
          (final e) => DsfrRadioButton<T>(
            title: e.value,
            value: e.key,
            groupValue: _value,
            onChanged: widget.isEnabled ? _handleChange : null,
          ),
        )
        .toList(growable: false);

    return switch (widget.mode) {
      DsfrRadioButtonSetMode.row => Wrap(spacing: DsfrSpacings.s1w, runSpacing: DsfrSpacings.s1w, children: children),
      DsfrRadioButtonSetMode.column => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: DsfrSpacings.s1w,
        children: children,
      ),
    };
  }
}
