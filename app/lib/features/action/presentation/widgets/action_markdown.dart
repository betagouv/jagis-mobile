import 'package:app/core/infrastructure/markdown.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class ActionMarkdown extends StatelessWidget {
  const ActionMarkdown({super.key, required this.data, this.hTag});

  final String data;
  final HTag? hTag;

  @override
  Widget build(final context) => FnvMarkdown(
    data: data.replaceAll(' ?', ' ?').replaceAll(' !', ' !'),
    h1: const DsfrTextStyle.headline4(),
    h2: const DsfrTextStyle.headline4(),
    h3: const DsfrTextStyle.headline5(),
    p: const DsfrTextStyle.bodyMd(),
    a: const DsfrTextStyle.bodyMd(color: DsfrColors.blueFranceSun113),
    hTag: hTag,
  );
}
