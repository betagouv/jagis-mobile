import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(type: FnvCheckboxSet, name: 'Default')
Widget buildCheckboxSetUseCase(final BuildContext context) => FnvCheckboxSet(
  options: const ['Option 1', 'Option 2', 'Option 3'],
  selectedOptions: const ['Option 1', 'Option 2'],
  onChanged: (final value) {},
);
