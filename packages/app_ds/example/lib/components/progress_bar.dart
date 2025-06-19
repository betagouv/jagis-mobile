import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(type: FnvProgressBar, name: 'Default')
Widget buildProgressBarUseCase(final BuildContext context) => FnvProgressBar(
  height: 8,
  trackColor: DsfrColorDecisions.backgroundContrastGrey(context),
  progressColor: DsfrColorDecisions.backgroundActiveBlueFrance(context),
  current: context.knobs.int.input(label: 'Courant', initialValue: 1),
  total: context.knobs.int.input(label: 'Total', initialValue: 8),
);
