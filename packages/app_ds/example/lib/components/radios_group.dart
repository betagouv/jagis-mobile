import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(type: FnvRadiosGroup, name: 'Default')
Widget buildRadiosGroupUseCase(final BuildContext context) => FnvRadiosGroup<String>(
  values: const {'value1': 'Label 1', 'value2': 'Label 2', 'value3': 'Label 3'},
  initialValue: 'value1',
  onChanged: (final value) {},
  direction: context.knobs.object.dropdown(label: 'Direction', options: Direction.values),
  size: context.knobs.object.dropdown(
    label: 'Taille',
    options: DsfrComponentSize.values.where((final element) => element != DsfrComponentSize.lg).toList(),
  ),
  enabled: context.knobs.boolean(label: 'Activé', initialValue: true),
);
