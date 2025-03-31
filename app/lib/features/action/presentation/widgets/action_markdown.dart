import 'package:app/core/infrastructure/markdown.dart';
import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class ActionMarkdown extends StatelessWidget {
  const ActionMarkdown({super.key, required this.data, this.hTag});

  final String data;
  final HTag? hTag;

  @override
  Widget build(final context) => FnvMarkdown(data: data, hTag: hTag);
}
