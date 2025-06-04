import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(type: FnvAccordion, name: 'Default')
Widget buildAccordionUseCase(final BuildContext context) => FnvAccordion(
  item: FnvAccordionItem(headerBuilder: (final isExpanded) => const Text('Accordion 1'), body: const Text('Content 1')),
  isExpanded: context.knobs.boolean(label: 'Ouvert'),
  onAccordionCallback: (final isExpanded) {},
);
