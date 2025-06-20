import 'package:app/core/infrastructure/markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvTitle extends StatelessWidget {
  const FnvTitle({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      FnvMarkdown(
        data: title,
        p: const DsfrTextStyle.headline2(color: DsfrColors.grey50),
        strong: const DsfrTextStyle.headline2(color: DsfrColors.blueFranceSun113),
      ),
      if (subtitle != null) ...[
        const SizedBox(height: DsfrSpacings.s1v5),
        Text(subtitle!, style: const DsfrTextStyle.bodyMd(color: DsfrColors.grey50)),
      ],
    ],
  );
}
