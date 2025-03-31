import 'package:app/features/action/presentation/widgets/action_markdown.dart';
import 'package:app/features/action/presentation/widgets/action_markdown_heading.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class ActionWhySectionView extends StatelessWidget {
  const ActionWhySectionView({super.key, required this.why});

  final String why;

  @override
  Widget build(final context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s1w, horizontal: DsfrSpacings.s2w),
    child: ActionMarkdown(
      data: why,
      hTag: ActionMarkdownHeading(icon: DsfrIcons.editorFrQuoteLine, color: DsfrColors.blueFranceSun113),
    ),
  );
}
