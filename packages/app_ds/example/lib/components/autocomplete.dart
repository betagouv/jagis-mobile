import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(type: FnvAutocomplete, name: 'Default')
Widget buildAutocompleteUseCase(final BuildContext context) => FnvAutocomplete(
  displayStringForOption: (final option) => option,
  onSearch: (final query) async => ['$query 1', '$query 2', '$query 3'],
  onSelected: (final option) {},
);
