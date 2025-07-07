import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(type: FnvStepper, name: 'Default')
Widget buildUseCase(final BuildContext context) => const FnvStepper(currentStep: 1, stepsCount: 2, stepTitle: 'Titre de l’étape');
