import 'package:app_ds/src/components/accordions/accordion.dart';
import 'package:app_ds/src/components/accordions/accordion_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvAccordionsGroup extends StatefulWidget {
  const FnvAccordionsGroup({super.key, required this.values});

  final List<FnvAccordionItem> values;

  @override
  State<FnvAccordionsGroup> createState() => _FnvAccordionsGroupState();
}

class _FnvAccordionsGroupState extends State<FnvAccordionsGroup> {
  int? _panelIndex;
  var _isExpanded = false;

  @override
  Widget build(final BuildContext context) {
    const divider = DsfrDivider();

    return Column(
      children: [
        divider,
        ...widget.values.indexed
            .map((final (int, FnvAccordionItem) e) {
              final (index, item) = e;

              return FnvAccordion(
                item: item,
                isExpanded: _panelIndex == index && _isExpanded,
                onAccordionCallback: (final isExpanded) {
                  setState(() {
                    _panelIndex = index;
                    _isExpanded = isExpanded;
                  });
                },
              );
            })
            .separator(divider),
        divider,
      ],
    );
  }
}
