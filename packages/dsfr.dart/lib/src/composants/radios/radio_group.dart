import 'package:dsfr/src/composants/radios/radio_group_headless.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrRadioButtonGroup<T> extends StatelessWidget {
  const DsfrRadioButtonGroup({super.key, required this.title, required this.values, required this.onChanged, this.initialValue});

  final String title;
  final Map<T, String> values;
  final T? initialValue;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s1w,
    children: [
      Text(title, style: const DsfrTextStyle.bodyMd()),
      DsfrRadioButtonGroupHeadless(values: values, onChanged: onChanged, initialValue: initialValue),
    ],
  );
}
