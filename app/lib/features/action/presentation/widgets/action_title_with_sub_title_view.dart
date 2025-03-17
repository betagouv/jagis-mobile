import 'package:app/core/infrastructure/markdown.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class ActionTitleWithSubTitleView extends StatelessWidget {
  const ActionTitleWithSubTitleView({super.key, required this.title, required this.subTitle});

  final String title;

  final String? subTitle;

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s2w,
    children: [
      FnvMarkdown(data: title, p: const DsfrTextStyle(fontSize: 28)),
      if (subTitle != null) Text(subTitle!, style: const DsfrTextStyle.bodyLg()),
    ],
  );
}
