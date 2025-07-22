// ignore_for_file: avoid-duplicate-constant-values

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvDateOnlyInput extends StatefulWidget {
  const FnvDateOnlyInput({
    super.key,
    required this.label,
    required this.hint,
    required this.maxYear,
    required this.initialValue,
    required this.onChanged,
    this.enabled = true,
  });

  final bool enabled;
  final String label;
  final String hint;
  final int maxYear;
  final DateTime? initialValue;
  final ValueChanged<DateTime> onChanged;

  @override
  State<FnvDateOnlyInput> createState() => _FnvDateOnlyInputState();
}

class _FnvDateOnlyInputState extends State<FnvDateOnlyInput> {
  static const _minDay = 1;
  static const _maxDay = 31;
  static const _minMonth = 1;
  static const _maxMonth = 12;
  static const _minYear = 1900;

  static const _lenghtDay = 2;
  static const _lenghtMonth = 2;
  static const _lenghtYear = 4;

  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();

  final _dayFocusNode = FocusNode();
  final _monthFocusNode = FocusNode();
  final _yearFocusNode = FocusNode();

  String? _dayError;
  String? _monthError;
  String? _yearError;
  String? _generalError;

  @override
  void initState() {
    super.initState();
    final dateTime = widget.initialValue;
    if (dateTime != null) {
      _dayController.text = dateTime.day.toString().padLeft(_lenghtDay, '0');
      _monthController.text = dateTime.month.toString().padLeft(_lenghtMonth, '0');
      _yearController.text = dateTime.year.toString();
    }

    _dayController.addListener(_onDayChanged);
    _monthController.addListener(_onMonthChanged);
    _yearController.addListener(_onYearChanged);
  }

  void _onDayChanged() {
    if (_validateLength(_dayController, _lenghtDay)) {
      _monthFocusNode.requestFocus();
    }
    _checkAndCreateDateTime();
  }

  void _onMonthChanged() {
    if (_validateLength(_monthController, _lenghtMonth)) {
      _yearFocusNode.requestFocus();
    }
    _checkAndCreateDateTime();
  }

  void _onYearChanged() {
    if (_validateLength(_yearController, _lenghtYear)) {
      _yearFocusNode.unfocus();
    }
    _checkAndCreateDateTime();
  }

  bool _validateLength(final TextEditingController controller, final int maxLength) =>
      controller.value.selection.isCollapsed &&
      controller.value.selection.baseOffset == maxLength &&
      controller.value.selection.affinity == TextAffinity.downstream &&
      controller.text.length == maxLength;

  void _checkAndCreateDateTime() {
    final dayText = _dayController.text;
    final monthText = _monthController.text;
    final yearText = _yearController.text;

    if (dayText.isNotEmpty && monthText.isNotEmpty && yearText.length == _lenghtYear) {
      final day = int.tryParse(dayText);
      final month = int.tryParse(monthText);
      final year = int.tryParse(yearText);

      if (day != null && month != null && year != null) {
        _validateAndSetDateTime(day, month, year);
      }
    }
  }

  void _validateAndSetDateTime(final int day, final int month, final int year) {
    final dayError = _validateDay(day);
    final monthError = _validateMonth(month);
    final yearError = _validateYear(year);

    setState(() {
      _generalError = null;
      _dayError = dayError;
      _monthError = monthError;
      _yearError = yearError;
    });

    if (dayError != null || monthError != null || yearError != null) {
      return;
    }

    final dateTime = _parseStrict(day, month, year);
    if (dateTime == null) {
      setState(() {
        _generalError = 'La date n’existe pas';
      });
    } else {
      widget.onChanged(dateTime);
    }
  }

  String? _validateDay(final int day) {
    if (day < _minDay || day > _maxDay) {
      return 'Le jour doit être compris entre $_minDay et $_maxDay';
    }

    return null;
  }

  String? _validateMonth(final int month) {
    if (month < _minMonth || month > _maxMonth) {
      return 'Le mois doit être compris entre $_minMonth et $_maxMonth';
    }

    return null;
  }

  String? _validateYear(final int year) {
    if (year < _minYear || year > widget.maxYear) {
      return 'L’année doit être comprise entre $_minYear et ${widget.maxYear}';
    }

    return null;
  }

  DateTime? _parseStrict(final int day, final int month, final int year) {
    final formattedString = _toYyyyMmDd(day, month, year);
    final date = DateTime.parse(formattedString);
    final originalFormatString = _dateTimeToYyyyMmDd(date);

    return formattedString == originalFormatString ? date : null;
  }

  String _dateTimeToYyyyMmDd(final DateTime dateTime) => _toYyyyMmDd(dateTime.day, dateTime.month, dateTime.year);

  String _toYyyyMmDd(final int day, final int month, final int year) {
    final y = year.toString();
    final m = month.toString().padLeft(_lenghtMonth, '0');
    final d = day.toString().padLeft(_lenghtDay, '0');

    return '$y$m$d';
  }

  @override
  void dispose() {
    _dayController
      ..removeListener(_onDayChanged)
      ..dispose();
    _dayFocusNode.dispose();

    _monthController
      ..removeListener(_onMonthChanged)
      ..dispose();
    _monthFocusNode.dispose();

    _yearController
      ..removeListener(_onYearChanged)
      ..dispose();
    _yearFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final messages = [?_dayError, ?_monthError, ?_yearError, ?_generalError];

    return _FnvFormState(
      componentState: messages.isNotEmpty ? DsfrComponentStateEnum.error : DsfrComponentStateEnum.none,
      messages: messages,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DsfrSpacings.s2w,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: DsfrSpacings.s1w,
            children: [
              Text(widget.label, style: DsfrTextStyle.bodyMd(color: DsfrColorDecisions.textLabelGrey(context))),
              Text(widget.hint, style: DsfrTextStyle.bodyXs(color: DsfrColorDecisions.textMentionGrey(context))),
            ],
          ),
          Row(
            spacing: DsfrSpacings.s2w,
            children: [
              SizedBox(
                width: 80,
                child: DsfrInput(
                  label: 'Jour',
                  hintText: 'Exemple : 14',
                  controller: _dayController,
                  enabled: widget.enabled,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)],
                  focusNode: _dayFocusNode,
                ),
              ),
              SizedBox(
                width: 80,
                child: DsfrInput(
                  label: 'Mois',
                  hintText: 'Exemple : 09',
                  controller: _monthController,
                  enabled: widget.enabled,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)],
                  focusNode: _monthFocusNode,
                ),
              ),
              SizedBox(
                width: 110,
                child: DsfrInput(
                  label: 'Année',
                  hintText: 'Exemple : 1984',
                  controller: _yearController,
                  enabled: widget.enabled,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
                  focusNode: _yearFocusNode,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FnvFormState extends StatelessWidget {
  const _FnvFormState({required this.componentState, required this.messages, required this.child});

  final DsfrComponentStateEnum componentState;
  final List<String> messages;
  final Widget child;

  @override
  Widget build(final BuildContext context) => componentState == DsfrComponentStateEnum.none
      ? child
      : IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: DsfrSpacings.s3v,
            children: [
              _FnvVerticalBarWidget(componentState: componentState),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: DsfrSpacings.s2w,
                  children: [
                    child,
                    _FnvComponentStateWidget(componentState: componentState, messages: messages),
                  ],
                ),
              ),
            ],
          ),
        );
}

class _FnvVerticalBarWidget extends StatelessWidget {
  const _FnvVerticalBarWidget({required this.componentState});

  final DsfrComponentStateEnum componentState;

  Color? _getColor(final BuildContext context) => switch (componentState) {
    DsfrComponentStateEnum.highlight => DsfrColorDecisions.borderDefaultBlueFrance(context),
    DsfrComponentStateEnum.error => DsfrColorDecisions.borderPlainError(context),
    DsfrComponentStateEnum.success => DsfrColorDecisions.borderPlainSuccess(context),
    DsfrComponentStateEnum.info || DsfrComponentStateEnum.warning || DsfrComponentStateEnum.none => null,
  };

  @override
  Widget build(final context) => componentState == DsfrComponentStateEnum.none
      ? const SizedBox.shrink()
      : VerticalDivider(width: 0, thickness: 2, color: _getColor(context));
}

class _FnvComponentStateWidget extends StatelessWidget {
  const _FnvComponentStateWidget({required this.componentState, required this.messages});

  final DsfrComponentStateEnum componentState;
  final List<String> messages;

  Color _getTextColor(final BuildContext context, final DsfrComponentStateEnum componentStateEnum) {
    switch (componentStateEnum) {
      case DsfrComponentStateEnum.error:
        return DsfrColorDecisions.textDefaultError(context);
      case DsfrComponentStateEnum.success:
        return DsfrColorDecisions.textDefaultSuccess(context);
      case DsfrComponentStateEnum.info:
        return DsfrColorDecisions.textDefaultInfo(context);
      case DsfrComponentStateEnum.warning:
        return DsfrColorDecisions.textDefaultWarning(context);
      case DsfrComponentStateEnum.none:
        return DsfrColorDecisions.textDefaultGrey(context);
      case DsfrComponentStateEnum.highlight:
        throw UnimplementedError();
    }
  }

  @override
  Widget build(final BuildContext context) => messages.isEmpty
      ? const SizedBox.shrink()
      : Column(
          spacing: DsfrSpacings.s1v,
          children: messages
              .map(
                (final e) => Row(
                  spacing: DsfrSpacings.s1v,
                  children: [
                    DsfrComponentStateIcon(state: componentState),
                    Flexible(
                      child: Text(e, style: DsfrTextStyle.bodyXs(color: _getTextColor(context, componentState))),
                    ),
                  ],
                ),
              )
              .toList(),
        );
}
