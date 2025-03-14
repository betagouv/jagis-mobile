import 'package:dsfr/src/composants/stepper/stepper_track.dart';
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrStepper extends StatelessWidget {
  const DsfrStepper({super.key, required this.title, required this.current, required this.total});

  final String title;
  final int current;
  final int total;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Question $current sur $total', style: const DsfrTextStyle.bodySm(color: DsfrColors.grey200)),
      const SizedBox(height: DsfrSpacings.s1v),
      Text(title, style: const DsfrTextStyle.headline6()),
      const SizedBox(height: DsfrSpacings.s3v),
      DsfrStepperTrack(current: current, total: total),
    ],
  );
}
