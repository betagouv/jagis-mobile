import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(type: FnvLoader, name: 'Default')
Widget buildLoaderUseCase(final BuildContext context) => const FnvLoader();
