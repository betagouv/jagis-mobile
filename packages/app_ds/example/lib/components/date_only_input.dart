import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(type: FnvDateOnlyInput, name: 'Default')
Widget buildDateOnlyInputUseCase(final BuildContext context) => Padding(
  padding: const EdgeInsets.all(16),
  child: FnvDateOnlyInput(
    label: 'Date de naissance',
    hint: 'Indication : texte de description additionnel',
    maxYear: DateTime.now().year,
    initialValue: null,
    onChanged: print,
  ),
);
