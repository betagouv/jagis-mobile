import 'package:app/core/infrastructure/markdown.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s1v5,
    children: [
      FnvMarkdown(
        data: title,
        p: const DsfrTextStyle.headline4(),
        strong: const DsfrTextStyle.headline4(color: DsfrColors.blueFranceSun113),
      ),
      FnvMarkdown(data: subTitle, p: const DsfrTextStyle.bodyMd()),
    ],
  );
}
