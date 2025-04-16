import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class QuestionStepper extends StatelessWidget {
  const QuestionStepper({super.key, required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(final BuildContext context) => Text.rich(
    TextSpan(
      text: 'Question ',
      children: [
        TextSpan(text: '$current sur $total', style: const DsfrTextStyle.bodyMdBold(color: DsfrColors.blueFranceSun113)),
      ],
    ),
    style: const DsfrTextStyle.bodyMd(color: DsfrColors.blueFranceSun113),
  );
}
