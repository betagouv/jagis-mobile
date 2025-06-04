import 'package:flutter/material.dart';

typedef FnvAccordionHeaderBuilder = Widget Function(bool isExpanded);

class FnvAccordionItem {
  const FnvAccordionItem({this.headerBuilder, required this.body, this.isEnable = true});

  final FnvAccordionHeaderBuilder? headerBuilder;
  final Widget body;
  final bool isEnable;
}
