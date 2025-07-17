import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(type: FnvDateOnlyInput, name: 'Default')
Widget buildDateOnlyInputUseCase(final BuildContext context) =>
    const Padding(padding: EdgeInsets.all(16), child: FnvDateOnlyInput());
