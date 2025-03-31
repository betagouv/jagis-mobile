import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class ActionTitleWithSubTitleView extends StatelessWidget {
  const ActionTitleWithSubTitleView({super.key, required this.title, required this.subTitle, required this.type});

  final String title;
  final String? subTitle;
  final ActionType type;

  @override
  Widget build(final context) {
    final fullTitle =
        switch (type) {
          ActionType.quiz => 'Quiz - ',
          ActionType.simulator => 'Simulateur - ',
          ActionType.performance => 'Bilan - ',
          ActionType.classic => '',
        } +
        title;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s3v,
      children: [
        FnvMarkdown(data: fullTitle, p: const DsfrTextStyle(fontSize: 28)),
        if (subTitle != null) FnvMarkdown(data: subTitle!, p: const DsfrTextStyle.bodyLg()),
      ],
    );
  }
}
