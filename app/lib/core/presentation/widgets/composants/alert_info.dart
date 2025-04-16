import 'package:app/core/infrastructure/markdown.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class FnvAlertInfo extends StatelessWidget {
  const FnvAlertInfo({super.key, required this.label, this.content});

  final String label;
  final Widget? content;

  @override
  Widget build(final BuildContext context) {
    Widget child = Row(
      spacing: DsfrSpacings.s1w,
      children: [
        const Icon(DsfrIcons.systemQuestionLine, color: DsfrColors.blueFranceSun113),
        Expanded(child: FnvMarkdown(data: label, p: const DsfrTextStyle(fontSize: 15))),
      ],
    );
    if (content != null) {
      child = Column(children: [child, content!]);
    }

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: DsfrColors.info950,
        border: Border.fromBorderSide(BorderSide(color: DsfrColors.blueFranceMain525)),
      ),
      child: Padding(padding: const EdgeInsets.all(DsfrSpacings.s2w), child: child),
    );
  }
}
