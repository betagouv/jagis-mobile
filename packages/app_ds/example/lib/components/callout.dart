import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(type: FnvCallout, name: 'Default')
Widget buildCalloutUseCase(final BuildContext context) =>
    const FnvCallout(child: Text('This is a callout widget. It can be used to highlight important information or warnings.'));
