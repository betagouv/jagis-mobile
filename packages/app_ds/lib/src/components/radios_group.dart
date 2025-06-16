import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvRadiosGroup<T> extends StatefulWidget {
  const FnvRadiosGroup({
    super.key,
    required this.values,
    this.initialValue,
    required this.onChanged,
    required this.direction,
    required this.size,
    this.enabled = true,
    this.isRich = true,
  });

  final Map<T, String> values;
  final T? initialValue;
  final ValueChanged<T?> onChanged;
  final Direction direction;
  final DsfrComponentSize size;
  final bool enabled;
  final bool isRich;

  @override
  State<FnvRadiosGroup<T>> createState() => _FnvRadiosGroupState<T>();
}

class _FnvRadiosGroupState<T> extends State<FnvRadiosGroup<T>> {
  T? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(final context) => DsfrGroup(
    direction: widget.direction,
    children: widget.values.entries
        .map(
          (final entry) => widget.isRich
              ? DsfrRadioRichButton<T>(
                  title: entry.value,
                  value: entry.key,
                  groupValue: _value,
                  onChanged: (final value) {
                    setState(() {
                      _value = value;
                    });
                    widget.onChanged(_value);
                  },
                  enabled: widget.enabled,
                  size: widget.size,
                  isExpanded: widget.direction == Direction.vertical,
                )
              : DsfrRadioButton<T>(
                  label: entry.value,
                  value: entry.key,
                  groupValue: _value,
                  onChanged: (final value) {
                    setState(() {
                      _value = value;
                    });
                    widget.onChanged(_value);
                  },
                  enabled: widget.enabled,
                  size: widget.size,
                ),
        )
        .toList(),
  );
}
