import 'package:clock/clock.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

final _dateFormat = DateFormat('dd/MM/yyyy', 'fr_FR');

class FnvInputCalendar extends StatefulWidget {
  const FnvInputCalendar({
    super.key,
    this.hintText,
    required this.label,
    this.initialValue,
    required this.onDateSelected,
    this.enabled = true,
  });

  final String? hintText;
  final String label;
  final DateTime? initialValue;
  final ValueChanged<DateTime?> onDateSelected;
  final bool enabled;

  @override
  State<FnvInputCalendar> createState() => _FnvInputCalendarState();
}

class _FnvInputCalendarState extends State<FnvInputCalendar> {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocus);
    _controller.text = widget.initialValue == null ? '' : _dateFormat.format(widget.initialValue!);
  }

  Future<void> _onFocus() async {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
      await _selectDate(context);
    }
  }

  Future<void> _selectDate(final BuildContext context) async {
    final now = context.read<Clock>().now();
    final initialDate = widget.initialValue ?? DateTime(now.year - 18);
    final dateSelected = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(now.year - 123),
      lastDate: now,
    );
    if (dateSelected == null) {
      return;
    }
    _controller.text = _dateFormat.format(dateSelected);
    widget.onDateSelected(dateSelected);
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_onFocus)
      ..dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => GestureDetector(
    onTap: widget.enabled ? () async => _selectDate(context) : null,
    child: AbsorbPointer(
      child: DsfrInput(
        label: widget.label,
        hintText: widget.hintText,
        focusNode: _focusNode,
        controller: _controller,
        enabled: widget.enabled,
      ),
    ),
  );
}
