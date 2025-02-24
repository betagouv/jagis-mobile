import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class FnvTitle extends StatelessWidget {
  const FnvTitle({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      MarkdownBody(
        data: title,
        styleSheet: MarkdownStyleSheet(
          p: const DsfrTextStyle.headline2(),
          strong: const DsfrTextStyle.headline2(color: DsfrColors.blueFranceSun113),
        ),
      ),
      if (subtitle != null) ...[const SizedBox(height: DsfrSpacings.s1v5), Text(subtitle!, style: const DsfrTextStyle.bodyMd())],
    ],
  );
}
