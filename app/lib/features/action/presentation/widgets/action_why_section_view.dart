import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/features/action/presentation/widgets/action_markdown.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class ActionWhySectionView extends StatelessWidget {
  const ActionWhySectionView({super.key, required this.why});

  final String why;

  @override
  Widget build(final context) {
    final (heading: whyFirstHeading, content: whyContent) = parseFirstHeadingInMardown(why);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s4w, horizontal: DsfrSpacings.s2w),
      child: Column(
        spacing: DsfrSpacings.s1w,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: DsfrSpacings.s1w,
            children: [
              const Icon(DsfrIcons.editorFrQuoteLine, size: 32, color: DsfrColors.blueFranceSun113),
              Text(whyFirstHeading, style: const DsfrTextStyle.headline3()),
            ],
          ),
          ActionMarkdown(data: whyContent),
        ],
      ),
    );
  }
}
