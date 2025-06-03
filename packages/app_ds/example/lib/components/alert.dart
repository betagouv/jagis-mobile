import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(type: FnvAlert, name: 'Error')
Widget buildCoolButtonUseCase(final BuildContext context) => FnvAlert.error(
  label: context.knobs.string(label: 'Label', initialValue: 'Une erreur est survenue'),
);
