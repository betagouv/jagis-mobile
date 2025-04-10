import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvRadioButtonGroup<T> extends StatefulWidget {
  const FnvRadioButtonGroup({
    super.key,
    required this.values,
    this.initialValue,
    required this.onChanged,
    required this.direction,
    this.enabled = true,
    required this.size,
  });

  final Map<T, String> values;
  final T? initialValue;
  final ValueChanged<T?> onChanged;
  final bool enabled;
  final Direction direction;
  final DsfrComponentSize size;

  @override
  State<FnvRadioButtonGroup<T>> createState() => _FnvRadioButtonGroupState<T>();
}

class _FnvRadioButtonGroupState<T> extends State<FnvRadioButtonGroup<T>> {
  T? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  void _handleChange(final T? value) {
    setState(() {
      _value = value;
    });
    widget.onChanged(_value);
  }

  @override
  Widget build(final context) => DsfrGroup(
    direction: widget.direction,
    children: widget.values.entries
        .map(
          (final entry) => DsfrRadioRichButton<T>(
            title: entry.value,
            value: entry.key,
            groupValue: _value,
            onChanged: _handleChange,
            enabled: widget.enabled,
            size: widget.size,
          ),
        )
        .toList(),
  );
}
