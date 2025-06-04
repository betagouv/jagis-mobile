import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(type: FnvAccordionsGroup, name: 'Default')
Widget buildAccordionsGroupUseCase(final BuildContext context) => FnvAccordionsGroup(
  values: [
    FnvAccordionItem(headerBuilder: (final isExpanded) => const Text('Accordion 1'), body: const Text('Content 1')),
    FnvAccordionItem(headerBuilder: (final isExpanded) => const Text('Accordion 2'), body: const Text('Content 2')),
  ],
);
