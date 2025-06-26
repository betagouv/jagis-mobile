import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(type: FnvToggleSwitch, name: 'Default')
Widget buildToggleSwitchUseCase(final BuildContext context) => const _UseCase();

class _UseCase extends StatefulWidget {
  const _UseCase();

  @override
  State<_UseCase> createState() => _UseCaseState();
}

class _UseCaseState extends State<_UseCase> {
  var _value = true;

  @override
  Widget build(final BuildContext context) => FnvToggleSwitch(
    leftLabel: 'Recommandées',
    rightLabel: 'Terminées',
    value: _value,
    onChanged: (final value) {
      setState(() {
        _value = value;
      });
    },
  );
}
